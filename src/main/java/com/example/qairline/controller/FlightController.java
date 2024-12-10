package com.example.qairline.controller;

import com.example.qairline.dto.request.AircraftRequest;
import com.example.qairline.dto.request.FlightRequest;
import com.example.qairline.dto.response.FlightResponse;
import com.example.qairline.dto.response.UserResponse;
import com.example.qairline.model.Flight;
import com.example.qairline.service.FlightService;
import com.example.qairline.util.SecurityUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping
public class FlightController {
    @Autowired
    private FlightService flightService;
    @Autowired
    private SecurityUtil securityUtil;
    @Autowired
    AuthController authController;

    @Transactional
    @GetMapping("/api/flights")
    @ResponseBody
    public Page<FlightResponse> getAllFlights(@RequestHeader("Authorization") String authorizationHeader, @RequestParam(defaultValue = "0") int page,
                                             @RequestParam(defaultValue = "5") int size) {
        if (isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            return flightService.getAllFlightsPaging(page, size); // Trả về JSON danh sách flights

        }
        return null;
    }

    @GetMapping("api/flightsSearch")
    @ResponseBody
    public Page<FlightResponse> getFlightsSearch(@RequestHeader("Authorization") String authorizationHeader, @RequestParam String keyword, @RequestParam int page, @RequestParam int size) {
        if (isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            return flightService.searchFlights(keyword, page, size);

        }
        return null;
    }

    @GetMapping("/api/getAllFlights")
    @ResponseBody
    public List<FlightResponse> getAllFlights(@RequestHeader("Authorization") String authorizationHeader) {
        if (isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            return flightService.getAllFlights();
        }
        return null;
    };

    @GetMapping("/admin/flights")
    public String getFlights(Model model) {
        model.addAttribute("flightsCount", flightService.getAllFlights().stream().count());
        model.addAttribute("pageCount", (flightService.getAllFlights().stream().count() + 4) / 5);

        return "admin/flights";
    }

    @PostMapping("/api/deleteflight")
    @ResponseBody
    public String deleteFlight(@RequestHeader("Authorization") String authorizationHeader, @RequestParam("flightId") Long flightId) {
        if (isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            flightService.deleteFlight(flightId);
            return "success";
        }
        return null;
    }

    @PostMapping("/admin/addflights")
    @ResponseBody
    public String addFlight(@RequestHeader("Authorization") String authorizationHeader, @ModelAttribute("addFlightModelAttribute") FlightRequest request, RedirectAttributes redirectAttributes) {
        if (isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            flightService.addFlight(request);
            return "success";
        }
        return null;
    }

    @GetMapping("/api/flights/{flightId}")
    @ResponseBody
    public FlightResponse getFlightById(@RequestHeader("Authorization") String authorizationHeader, @PathVariable Long flightId) {
        if (isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            return flightService.getFlightById(flightId);
        }
        return null;
    }


    @PutMapping("/api/flights/{flightId}")
    @ResponseBody
    public FlightResponse updateFlight(@RequestHeader("Authorization") String authorizationHeader, @PathVariable Long flightId, @RequestBody FlightRequest flightRequest) {
        if (isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            return flightService.editFlight(flightId, flightRequest);
        }
        return null;
    }

    boolean isAdmin() {
        String userName = securityUtil.getCurrentUserLogin().orElse(null);
        if (userName != null && userName.equals("admin")) {
            return true;
        }
        return false;
    }
}
