package com.example.qairline.service;

import com.example.qairline.dto.request.TicketRequest;
import com.example.qairline.dto.response.TicketResponse;
import com.example.qairline.dto.response.UserResponse;
import com.example.qairline.model.Promotion;
import com.example.qairline.model.Ticket;
import com.example.qairline.model.User;
import com.example.qairline.repository.FlightRepository;
import com.example.qairline.repository.PromotionRepository;
import com.example.qairline.repository.TicketRepository;
import com.example.qairline.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class TicketService {
    @Autowired
    TicketRepository ticketRepository;
    @Autowired
    FlightRepository flightRepository;
    @Autowired
    PromotionRepository promotionRepository;
    @Autowired
    UserRepository userRepository;

    public List<TicketResponse> getAllTickets() {
        return ticketRepository.findAll().stream().map(this::convertToDTO).toList();
    }


    public TicketResponse getTicketById(long id) {
        return convertToDTO(ticketRepository.findById(id));
    }

    public Page<TicketResponse> getTickets(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return ticketRepository.findAll(pageable).map(this::convertToDTO);
    }

    public Page<TicketResponse> getTicketsSearch(String search, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return ticketRepository.searchByKeyword(search, pageable).map(this::convertToDTO);
    }

    public void deleteTicketById(long id) {
        ticketRepository.deleteById(id);
    }

    public TicketResponse addTicket(TicketRequest request) {
        Ticket ticket = new Ticket();
        ticket.setFlight(flightRepository.findById(request.getFlightId()).orElse(null));
        //ticket.setUser(userRepository.findByUsername(request.getUserName()));
        ticket.setSeatNumber(request.getSeatNumber());

        List<Promotion> promotions = promotionRepository.findByStartDateBeforeAndEndDateAfter(LocalDateTime.now(), LocalDateTime.now());

        if (promotions.size() > 0) {
            Promotion promotion = promotions.get(0);
            ticket.setPromotion(promotion);
            ticket.setFinalPrice(ticket.getFlight().getTicketPrice() * (100 - promotion.getDiscountPercent()));
        } else {
            ticket.setPromotion(null);
            ticket.setFinalPrice(ticket.getFlight().getTicketPrice());
        }
        //ticket.setStatus(request.getStatus());
        ticketRepository.save(ticket);
        return convertToDTO(ticket);
    }

    public TicketResponse updateTicket(long id, UserResponse userResponse) {
        Ticket ticket = ticketRepository.findById(id);
        User user = new User();
        user.setUserId(userResponse.getUserId());
        user.setUsername(userResponse.getUsername());
        user.setEmail(userResponse.getEmail());
        user.setPhoneNumber(String.valueOf(userResponse.getPhoneNumber()));
        user.setAddress(String.valueOf(userResponse.getAddress()));
        user.setRole(userResponse.getRole());
        user.setCreatedAt(user.getCreatedAt());
        ticket.setUser(user);
        return convertToDTO(ticket);
    }

    public TicketResponse convertToDTO(Ticket ticket) {
        return new TicketResponse(ticket.getTicketId(), ticket.getFlight().getFlightId(), ticket.getUser().getUsername(), ticket.getSeatNumber(), ticket.getStatus(), ticket.getFinalPrice(), ticket.getPromotion().getPromotionId());
    }
}
