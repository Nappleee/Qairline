package com.example.qairline.controller;

import com.example.qairline.dto.request.AircraftRequest;
import com.example.qairline.dto.response.AircraftResponse;
import com.example.qairline.dto.response.UserResponse;
import com.example.qairline.model.Aircraft;
import com.example.qairline.service.AircraftService;
import com.example.qairline.util.JwtTokenBlacklist;
import com.example.qairline.util.SecurityUtil;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping
public class AircraftController {
    @Autowired
    private AircraftService aircraftService;
    @Autowired
    private SecurityUtil securityUtil;
    @Autowired
    private JwtTokenBlacklist jwtTokenBlacklist;
    @Autowired
    AuthController authController;

    @GetMapping("api/aircrafts")
    @ResponseBody
    public Page<AircraftResponse> getAllAircrafts(@RequestHeader("Authorization") String authorizationHeader, @RequestParam int page, @RequestParam int size) {
        if (isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            return aircraftService.getAllAircraftsPaging(page, size);
        }
        return null;
    }

    @GetMapping("api/aircraftsSearch")
    @ResponseBody
    public Page<AircraftResponse> getUsersSearch(@RequestHeader("Authorization") String authorizationHeader, @RequestParam String keyword, @RequestParam int page, @RequestParam int size) {
        String userName = securityUtil.getCurrentUserLogin().orElse(null);
        System.out.println(userName);
        // Kiểm tra role và trả về kết quả
        if (userName != null && userName.equals("admin") && !authController.isTokenBlacklisted(authorizationHeader)) {
            return aircraftService.searchAircrafts(keyword, page, size);
        } else {
            return null;
        }
    }

    @GetMapping("api/getAllAircrafts")
    @ResponseBody
    public List<AircraftResponse> getAllAircrafts(@RequestHeader("Authorization") String authorizationHeader) {
        String userName = securityUtil.getCurrentUserLogin().orElse(null);
        System.out.println(userName);
        // Kiểm tra role và trả về kết quả
        if (userName != null && userName.equals("admin")  && !authController.isTokenBlacklisted(authorizationHeader)) {
            return aircraftService.getAllAircrafts();
        } else {
            return null;
        }
    }

    @GetMapping("/admin/aircrafts")
    public String getAircrafts(Model model) {
        // Kiểm tra role và trả về kết quả
        model.addAttribute("aircraftsCount", aircraftService.getAllAircrafts().stream().count());
        model.addAttribute("pageCount", (aircraftService.getAllAircrafts().stream().count() + 4) / 5);
        return "admin/aircrafts";
    }

    @PostMapping("/admin/addaircrafts")
    @ResponseBody
    public String addAircraft(@RequestHeader("Authorization") String authorizationHeader, @ModelAttribute("addAircraftModelAttribute") AircraftRequest request, RedirectAttributes redirectAttributes) {
        if (isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            if (aircraftService.createAircraft(request) == null) {
                //redirectAttributes.addFlashAttribute("aircraftExisted", "Aircraft with this model already exists.");
                System.out.println("Aircraft already exists.");
                return "Aircraft with this model already exists.";
            };
            return "success";
        }
        return null;
    }

    @PostMapping("/api/deleteaircraft")
    @ResponseBody
    public String deleteFlight(@RequestHeader("Authorization") String authorizationHeader, @RequestParam() String model) {
        if (isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            aircraftService.deleteAircraft(model);
            return "success";
        }
        return null;
    }

    boolean isAdmin() {
        String userName = securityUtil.getCurrentUserLogin().orElse(null);
        System.out.println(userName);
        // Kiểm tra role và trả về kết quả
        if (userName != null && userName.equals("admin")) {
            return true;
        }
        return false;
    }


}
