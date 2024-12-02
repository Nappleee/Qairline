package com.example.qairline.dto.response;

import com.example.qairline.model.Flight;
import com.example.qairline.model.Promotion;
import com.example.qairline.model.User;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class TicketResponse {
    private Long ticketId;
    private Long flightId;
    private String userName;

    private String seatNumber;

    private String status;

    private Double finalPrice;
    private Long promotionId;
}
