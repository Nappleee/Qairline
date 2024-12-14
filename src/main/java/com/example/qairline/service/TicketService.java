package com.example.qairline.service;

import com.example.qairline.dto.request.TicketRequest;
import com.example.qairline.dto.response.TicketResponse;
import com.example.qairline.dto.response.UserResponse;
import com.example.qairline.model.Flight;
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
        System.out.println(ticketRepository.searchByKeyword(search, pageable));
        return ticketRepository.searchByKeyword(search, pageable).map(this::convertToDTO);
    }

    public Page<TicketResponse> getTicketsByUserisNull(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return ticketRepository.findByUserIsNull(pageable).map(this::convertToDTO);
    }

    public Page<TicketResponse> getTicketsByUserName(String username, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return ticketRepository.findByUsername(username, pageable).map(this::convertToDTO);
    }

    public void deleteTicketById(long id) {
        ticketRepository.deleteById(id);
    }

    public TicketResponse addTicket(TicketRequest request) {
        Ticket ticket = new Ticket();
        Flight flight = flightRepository.findById(request.getFlightId()).orElse(null);
        //System.out.println(flight);
        ticket.setFlight(flight);
        //ticket.setUser(userRepository.findByUsername(request.getUserName()));
        ticket.setSeatNumber(request.getSeatNumber());

        List<Promotion> promotions = promotionRepository.findByStartDateBeforeAndEndDateAfter(LocalDateTime.now(), LocalDateTime.now());

        if (promotions.size() > 0) {
            double discountTotal = 0;
            for (Promotion promotion : promotions) {
                discountTotal += promotion.getDiscountPercent();
            }
            Promotion promotion = promotions.get(0);
            ticket.setPromotion(promotion);
            ticket.setFinalPrice(ticket.getFlight().getTicketPrice() * (100 - discountTotal) / 100);
        } else {
            ticket.setPromotion(null);
            ticket.setFinalPrice(ticket.getFlight().getTicketPrice());
        }
        if (request.getUserName() != null) {
            ticket.setUser(userRepository.findByUsername(request.getUserName()));
            ticket.setStatus("PAID");
        } else {
            ticket.setUser(null);
            ticket.setStatus("AVAILABLE");
        }
        //ticket.setStatus(request.getStatus());
        ticketRepository.save(ticket);
        return convertToDTO(ticket);
    }

    public void updatePromotionInTicket() {
        List<Ticket> tickets = ticketRepository.findAllByStatus("AVAILABLE");
        if (tickets.size() > 0) {
            //promotion = tickets.get(0).getPromotion();
            List<Promotion> promotions = promotionRepository.findByStartDateBeforeAndEndDateAfter(LocalDateTime.now(), LocalDateTime.now());
            for (Ticket ticket : tickets) {
                if (promotions.size() > 0) {
                    Promotion promotion = promotions.get(0);
                    double discountTotal = promotion.getDiscountPercent();
                    ticket.setPromotion(promotion);
                    ticket.setFinalPrice(ticket.getFlight().getTicketPrice() * (100 - discountTotal) / 100);
                } else {
                    ticket.setPromotion(null);
                    ticket.setFinalPrice(ticket.getFlight().getTicketPrice());
                }
                ticketRepository.save(ticket);
            }
        }
    }

    public TicketResponse editTicket(long id, TicketRequest request) {
        Ticket ticket = ticketRepository.findById(id);
        ticket.setFlight(flightRepository.findById(request.getFlightId()).orElse(null));
        ticket.setSeatNumber(request.getSeatNumber());
        ticket.setUser(userRepository.findByUsername(request.getUserName()));
        ticket.setPromotion(promotionRepository.findById(request.getPromotionId()).orElse(null));
        return convertToDTO(ticket);
    }

    public TicketResponse convertToDTO(Ticket ticket) {
        String userName;
        Long promotionId;
        if (ticket.getUser() != null) {
            userName = ticket.getUser().getUsername();
        } else {
            userName = null;
        }
        if (ticket.getPromotion() != null) {
            promotionId = ticket.getPromotion().getPromotionId();
        } else {
            promotionId = null;
        }
        return new TicketResponse(ticket.getTicketId(), ticket.getFlight().getFlightId(), userName, ticket.getSeatNumber(), ticket.getStatus(), ticket.getFinalPrice(), promotionId);
    }

    public void addTicketForUser(TicketRequest request) {
        Ticket ticket = ticketRepository.findById(request.getTicketId())
                .orElseThrow(() -> new IllegalArgumentException("Ticket not found!"));
        User user = userRepository.findById(request.getUserId())
                .orElseThrow(() -> new IllegalArgumentException("User not found!"));

        if (!"AVAILABLE".equals(ticket.getStatus())) {
            throw new IllegalStateException("Ticket is not available!");
        }

        ticket.setUser(user);
        ticket.setStatus("PAID");
        ticketRepository.save(ticket);
    }

    public void userDeleteTicket(TicketRequest request) {
        Ticket ticket = ticketRepository.findById(request.getTicketId())
                .orElseThrow(() -> new IllegalArgumentException("Ticket not found!"));

        System.out.println("ABCDEFGH");
        ticket.setUser(null);
        ticket.setStatus("AVAILABLE");
        ticketRepository.save(ticket);
    }
}
