package com.example.qairline.controller;

import com.example.qairline.dto.request.AircraftRequest;
import com.example.qairline.dto.request.FlightRequest;
import com.example.qairline.dto.response.FlightResponse;
import com.example.qairline.dto.response.UserResponse;
import com.example.qairline.model.Flight;
import com.example.qairline.service.FlightService;
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

    @Transactional
    @GetMapping("/api/flights")
    @ResponseBody
    public Page<FlightResponse> getAllFlights(@RequestParam(defaultValue = "0") int page,
                                             @RequestParam(defaultValue = "5") int size) {
        return flightService.getAllFlightsPaging(page, size); // Trả về JSON danh sách flights
    }

    @GetMapping("api/flightsSearch")
    @ResponseBody
    public Page<FlightResponse> getFlightsSearch(@RequestParam String keyword, @RequestParam int page, @RequestParam int size) {

        return flightService.searchFlights(keyword, page, size);
    }

    @GetMapping("/api/getAllFlights")
    @ResponseBody
    public List<FlightResponse> getAllFlights() {
        return flightService.getAllFlights();
    };

    @GetMapping("/admin/flights")
    public String getFlights(Model model) {
        model.addAttribute("flightsCount", flightService.getAllFlights().stream().count());
        model.addAttribute("pageCount", (flightService.getAllFlights().stream().count() + 4) / 5);

        return "admin/flights";
    }

    @PostMapping("/api/deleteflight")
    @ResponseBody
    public String deleteFlight(@RequestParam("flightId") Long flightId) {
        flightService.deleteFlight(flightId);
        return "success";
    }

    @PostMapping("/admin/flights")
    @ResponseBody
    public String addFlight(@ModelAttribute("addFlightModelAttribute") FlightRequest request, RedirectAttributes redirectAttributes) {
        flightService.addFlight(request);
        return "success";
    }

    @GetMapping("/api/flights/{flightId}")
    @ResponseBody
    public FlightResponse getFlightById(@PathVariable Long flightId) {
        return flightService.getFlightById(flightId);
    }


    @PutMapping("/api/flights/{flightId}")
    @ResponseBody
    public FlightResponse updateFlight(@PathVariable Long flightId, @RequestBody FlightRequest flightRequest) {
        return flightService.editFlight(flightId, flightRequest);
    }


}
