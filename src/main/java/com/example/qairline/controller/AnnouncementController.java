package com.example.qairline.controller;

import com.example.qairline.dto.request.AircraftRequest;
import com.example.qairline.dto.request.AnnouncementRequest;
import com.example.qairline.dto.request.FlightRequest;
import com.example.qairline.dto.response.AircraftResponse;
import com.example.qairline.dto.response.AnnouncementResponse;
import com.example.qairline.dto.response.FlightResponse;
import com.example.qairline.service.AnnouncementService;
import com.example.qairline.util.SecurityUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping
public class AnnouncementController {
    @Autowired
    private AnnouncementService announcementService;
    @Autowired
    private SecurityUtil securityUtil;
    @Autowired
    AuthController authController;

    @GetMapping("api/announcements")
    @ResponseBody
    public Page<AnnouncementResponse> getAllAircrafts(@RequestHeader("Authorization") String authorizationHeader, @RequestParam int page, @RequestParam int size) {
        if (isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            return announcementService.getAllAnnouncementPaging(page, size);
        }
        return null;
    }

    @GetMapping("api/announcementsSearch")
    @ResponseBody
    public Page<AnnouncementResponse> getUsersSearch(@RequestHeader("Authorization") String authorizationHeader, @RequestParam String keyword, @RequestParam int page, @RequestParam int size) {
        if (isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            return announcementService.searchAnnouncements(keyword, page, size);
        }
        return null;
    }

    @GetMapping("/api/announcements/{announcementId}")
    @ResponseBody
    public AnnouncementResponse getFlightById(@RequestHeader("Authorization") String authorizationHeader, @PathVariable Long announcementId) {
        if (isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            return announcementService.getAnnouncementById(announcementId);
        }
        return null;
    }

    @GetMapping("/admin/announcements")
    public String getAnnouncements(Model model) {
        model.addAttribute("announcementsCount", announcementService.getAllAnnouncement().stream().count());
        model.addAttribute("pageCount", (announcementService.getAllAnnouncement().stream().count() + 4) / 5);
        return "admin/announcements";
    }

    @PostMapping("/admin/addannouncements")
    @ResponseBody
    public String addAnnouncement(@RequestHeader("Authorization") String authorizationHeader, @ModelAttribute("addAnnouncementModelAttribute") AnnouncementRequest request, RedirectAttributes redirectAttributes) {
        if (isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            if (announcementService.addAnnouncement(request) == null) {
                //redirectAttributes.addFlashAttribute("aircraftExisted", "Aircraft with this model already exists.");
                return "already exists.";
            };
            return "success";
        }
        return null;
    }

    @PostMapping("/api/announcements/{announcementId}")
    @ResponseBody
    public AnnouncementResponse updateAnnouncements(@RequestHeader("Authorization") String authorizationHeader, @PathVariable Long announcementId, @RequestBody AnnouncementRequest request) {
        if (isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            return announcementService.updateAnnouncement(announcementId, request);

        }
        return null;
    }

    @PostMapping("/api/deleteannouncement")
    @ResponseBody
    public String deleteAnnouncements(@RequestHeader("Authorization") String authorizationHeader, @RequestParam("announcementId") Long announcementId) {
        if (isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            announcementService.deleteAnnouncement(announcementId);
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
