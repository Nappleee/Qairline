package com.example.qairline.dto.request;

import com.example.qairline.model.Aircraft;
import jakarta.validation.constraints.NotEmpty;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class FlightRequest {
    @NotEmpty
    private String aircraftModel;
    @NotEmpty
    private String departure;
    @NotEmpty
    private String destination;
    @NotEmpty
    private LocalDateTime departureTime;
    @NotEmpty
    private Double ticketPrice;
}
