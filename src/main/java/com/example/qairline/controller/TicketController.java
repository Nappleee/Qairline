package com.example.qairline.controller;

import com.example.qairline.dto.request.TicketRequest;
import com.example.qairline.dto.response.TicketResponse;
import com.example.qairline.service.TicketService;
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
public class TicketController {
    @Autowired
    private TicketService ticketService;

    @Transactional
    @GetMapping("/api/tickets")
    @ResponseBody
    public Page<TicketResponse> getAllFlights(@RequestParam(defaultValue = "0") int page,
                                              @RequestParam(defaultValue = "5") int size) {
        return ticketService.getTickets(page, size); // Trả về JSON danh sách flights
    }

    @GetMapping("/api/getAllTickets")
    @ResponseBody
    public List<TicketResponse> getAllFlights() {
        return ticketService.getAllTickets();
    };

    @GetMapping("api/ticketsSearch")
    @ResponseBody
    public Page<TicketResponse> getFlightsSearch(@RequestParam String keyword, @RequestParam int page, @RequestParam int size) {

        return ticketService.getTicketsSearch(keyword, page, size);
    }

    @GetMapping("/admin/tickets")
    public String getFlights(Model model) {
        model.addAttribute("ticketsCount", ticketService.getAllTickets().stream().count());
        model.addAttribute("pageCount", (ticketService.getAllTickets().stream().count() + 4) / 5);

        return "admin/tickets";
    }

    @PostMapping("/api/deleteticket")
    @ResponseBody
    public String deleteFlight(@RequestParam("ticketId") Long ticketId) {
        ticketService.deleteTicketById(ticketId);
        return "success";
    }

    @PostMapping("/admin/tickets")
    @ResponseBody
    public String addFlight(@ModelAttribute("addFlightModelAttribute") TicketRequest request, RedirectAttributes redirectAttributes) {
        ticketService.addTicket(request);
        return "success";
    }

    @GetMapping("/api/tickets/{ticketId}")
    @ResponseBody
    public TicketResponse getFlightById(@PathVariable Long ticketId) {
        return ticketService.getTicketById(ticketId);
    }
}
