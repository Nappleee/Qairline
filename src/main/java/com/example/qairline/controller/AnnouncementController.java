package com.example.qairline.controller;

import com.example.qairline.dto.request.AircraftRequest;
import com.example.qairline.dto.request.AnnouncementRequest;
import com.example.qairline.dto.request.FlightRequest;
import com.example.qairline.dto.response.AircraftResponse;
import com.example.qairline.dto.response.AnnouncementResponse;
import com.example.qairline.dto.response.FlightResponse;
import com.example.qairline.service.AnnouncementService;
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

    @GetMapping("api/announcements")
    @ResponseBody
    public Page<AnnouncementResponse> getAllAircrafts(@RequestParam int page, @RequestParam int size) {
        return announcementService.getAllAnnouncementPaging(page, size);
    }

    @GetMapping("api/announcementsSearch")
    @ResponseBody
    public Page<AnnouncementResponse> getUsersSearch(@RequestParam String keyword, @RequestParam int page, @RequestParam int size) {
        return announcementService.searchAnnouncements(keyword, page, size);
    }

    @GetMapping("/api/announcements/{announcementId}")
    @ResponseBody
    public AnnouncementResponse getFlightById(@PathVariable Long announcementId) {
        return announcementService.getAnnouncementById(announcementId);
    }

    @GetMapping("/admin/announcements")
    public String getAnnouncements(Model model) {
        model.addAttribute("announcementsCount", announcementService.getAllAnnouncement().stream().count());
        model.addAttribute("pageCount", (announcementService.getAllAnnouncement().stream().count() + 4) / 5);
        return "admin/announcements";
    }

    @PostMapping("/admin/announcements")
    @ResponseBody
    public String addAnnouncement(@ModelAttribute("addAnnouncementModelAttribute") AnnouncementRequest request, RedirectAttributes redirectAttributes) {
        if (announcementService.addAnnouncement(request) == null) {
            //redirectAttributes.addFlashAttribute("aircraftExisted", "Aircraft with this model already exists.");
            return "already exists.";
        };
        return "success";
    }

    @PostMapping("/api/announcements/{announcementId}")
    @ResponseBody
    public AnnouncementResponse updateAnnouncements(@PathVariable Long announcementId, @RequestBody AnnouncementRequest request) {
        return announcementService.updateAnnouncement(announcementId, request);
    }

    @PostMapping("/api/deleteannouncement")
    @ResponseBody
    public String deleteAnnouncements(@RequestParam("announcementId") Long announcementId) {
        announcementService.deleteAnnouncement(announcementId);
        return "success";
    }
}
