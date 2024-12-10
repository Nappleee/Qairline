package com.example.qairline.Component;

import com.example.qairline.service.TicketService;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

@Component
public class ApplicationStartup {

    private final TicketService ticketService;

    public ApplicationStartup(TicketService ticketService) {
        this.ticketService = ticketService;
    }

    @EventListener(ApplicationReadyEvent.class)
    public void onApplicationReady() {
        ticketService.updatePromotionInTicket();
        System.out.println("Checked and updated expired promotions in tickets.");
    }
}

