package com.example.qairline.dto.response;

import com.example.qairline.model.Aircraft;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class FlightResponse {
    private Long flightId;
    private String aircraft; // Lấy thông tin model từ `Aircraft`
    private String departure;
    private String destination;
    private String departureTime;
    private Double ticketPrice;

    public FlightResponse(Long flightId,String aircraftModel, String departure, String destination, LocalDateTime departureTime, Double ticketPrice) {
        this.flightId = flightId;
        this.aircraft = aircraftModel;
        this.departure = departure;
        this.destination = destination;
        this.departureTime = formatDateTime(departureTime);
        this.ticketPrice = ticketPrice;
    }

    private String formatDateTime(LocalDateTime dateTime) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'<br>'HH:mm:ss");
        return dateTime.format(formatter);
    }
}
