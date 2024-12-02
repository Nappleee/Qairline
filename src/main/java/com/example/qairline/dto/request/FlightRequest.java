package com.example.qairline.dto.request;

import com.example.qairline.model.Aircraft;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class FlightRequest {
    private String aircraftModel;
    private String departure;
    private String destination;
    private LocalDateTime departureTime;
    private Double ticketPrice;
}
