package com.example.qairline.dto.request;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class TicketRequest {
    private Long flightId;

    private String userName;

    private String seatNumber;

    //private String status;

    //private Double finalPrice;
    private Long promotionId;


    private Long ticketId;
    private Long userId;
}
