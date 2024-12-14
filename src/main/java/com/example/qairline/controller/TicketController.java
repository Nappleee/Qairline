package com.example.qairline.controller;

import com.example.qairline.dto.request.FlightRequest;
import com.example.qairline.dto.request.TicketRequest;
import com.example.qairline.dto.response.FlightResponse;
import com.example.qairline.dto.response.TicketResponse;
import com.example.qairline.service.TicketService;
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
public class TicketController {
    @Autowired
    private TicketService ticketService;
    @Autowired
    private SecurityUtil securityUtil;
    @Autowired
    AuthController authController;


    @Transactional
    @GetMapping("/api/tickets")
    @ResponseBody
    public Page<TicketResponse> getAllTickets(@RequestHeader("Authorization") String authorizationHeader, @RequestParam(defaultValue = "0") int page,
                                              @RequestParam(defaultValue = "5") int size) {
        if (isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            return ticketService.getTickets(page, size);
        }
        return null;
    }

    @GetMapping("/api/getAllTickets")
    @ResponseBody
    public List<TicketResponse> getAllTickets() {
            return ticketService.getAllTickets();
    };

    @GetMapping("api/ticketsSearch")
    @ResponseBody
    public Page<TicketResponse> getTicketsSearch(@RequestHeader("Authorization") String authorizationHeader, @RequestParam String keyword, @RequestParam int page, @RequestParam int size) {
        if (isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            return ticketService.getTicketsSearch(keyword, page, size);
        }
        return null;
    }

    @GetMapping("api/ticketsByUserisNull")
    @ResponseBody
    public Page<TicketResponse> getTicketsByUserisNull(@RequestHeader("Authorization") String authorizationHeader, @RequestParam int page, @RequestParam int size) {
        if (isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            return ticketService.getTicketsByUserisNull(page, size);
        }
        return null;
    }

    @GetMapping("api/ticketsByUserName")
    @ResponseBody
    public Page<TicketResponse> getTicketsByUserName(@RequestHeader("Authorization") String authorizationHeader, @RequestParam String username, @RequestParam int page, @RequestParam int size) {
        if (isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            return ticketService.getTicketsByUserName(username, page, size);
        }
        return null;
    }

    @GetMapping("/admin/tickets")
    public String getTickets(Model model) {

        model.addAttribute("ticketsCount", ticketService.getAllTickets().stream().count());
        model.addAttribute("pageCount", (ticketService.getAllTickets().stream().count() + 4) / 5);

        return "admin/tickets";
    }

    @PostMapping("/api/deleteticket")
    @ResponseBody
    public String deleteTicket(@RequestHeader("Authorization") String authorizationHeader, @RequestParam("ticketId") Long ticketId) {
        if (isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            ticketService.deleteTicketById(ticketId);
            ticketService.updatePromotionInTicket();
            return "success";
        }
        return null;
    }

    @Transactional
    @PostMapping("/admin/addtickets")
    @ResponseBody
    public String addTicket(@RequestHeader("Authorization") String authorizationHeader, @ModelAttribute("addTicketModelAttribute") TicketRequest request, RedirectAttributes redirectAttributes) {
        if (isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            ticketService.addTicket(request);
            ticketService.updatePromotionInTicket();
            return "success";
        }
        return null;
    }

    @GetMapping("/api/tickets/{ticketId}")
    @ResponseBody
    public TicketResponse getTicketById(@RequestHeader("Authorization") String authorizationHeader, @PathVariable Long ticketId) {
        if (isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            return ticketService.getTicketById(ticketId);
        }
        return null;
    }

    @PutMapping("/api/tickets/{ticketId}")
    @ResponseBody
    public TicketResponse editTicket(@RequestHeader("Authorization") String authorizationHeader, @PathVariable Long ticketId, @RequestBody TicketRequest ticketRequest) {
        if (isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            ticketService.updatePromotionInTicket();
            return ticketService.editTicket(ticketId, ticketRequest);
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

    @GetMapping("/test")
    public String test(Model model) {
        return "user/test";
    }

    @Transactional
    @PostMapping("/addtickets")
    @ResponseBody
    public String addTicketForUser(@RequestBody TicketRequest request) {
        if (request.getTicketId() == null || request.getUserId() == null) {
            throw new IllegalArgumentException("Ticket ID and User ID must not be null!");
        }
        ticketService.addTicketForUser(request);
        return "Ticket assigned successfully!";
    }


    @PostMapping("/userdeleteticket")
    @ResponseBody
    public String userDeleteTicket(@RequestBody TicketRequest request) {
            ticketService.userDeleteTicket(request);
            return "success";
    }
}

