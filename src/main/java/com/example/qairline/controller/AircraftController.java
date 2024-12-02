package com.example.qairline.controller;

import com.example.qairline.dto.request.AircraftRequest;
import com.example.qairline.dto.response.AircraftResponse;
import com.example.qairline.dto.response.UserResponse;
import com.example.qairline.model.Aircraft;
import com.example.qairline.service.AircraftService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping
public class AircraftController {
    @Autowired
    private AircraftService aircraftService;

    @GetMapping("api/aircrafts")
    @ResponseBody
    public Page<AircraftResponse> getAllAircrafts(@RequestParam int page, @RequestParam int size) {
        return aircraftService.getAllAircraftsPaging(page, size);
    }

    @GetMapping("api/aircraftsSearch")
    @ResponseBody
    public Page<AircraftResponse> getUsersSearch(@RequestParam String keyword, @RequestParam int page, @RequestParam int size) {
        return aircraftService.searchAircrafts(keyword, page, size);
    }

    @GetMapping("api/getAllAircrafts")
    @ResponseBody
    public List<AircraftResponse> getAllAircrafts() {
        return aircraftService.getAllAircrafts();
    }

    @GetMapping("/admin/aircrafts")
    public String getFlights(Model model) {
        model.addAttribute("aircraftsCount", aircraftService.getAllAircrafts().stream().count());
        model.addAttribute("pageCount", (aircraftService.getAllAircrafts().stream().count() + 4) / 5);
        return "admin/aircrafts";
    }

    @PostMapping("/admin/aircrafts")
    @ResponseBody
    public String addAircraft(@ModelAttribute("addAircraftModelAttribute") AircraftRequest request, RedirectAttributes redirectAttributes) {
        if (aircraftService.createAircraft(request) == null) {
            //redirectAttributes.addFlashAttribute("aircraftExisted", "Aircraft with this model already exists.");
            System.out.println("Aircraft already exists.");
            return "Aircraft with this model already exists.";
        };
        return "success";
    }

    @PostMapping("/api/deleteaircraft")
    @ResponseBody
    public String deleteFlight(@RequestParam() String model) {
        aircraftService.deleteAircraft(model);
        return "success";
    }
}
