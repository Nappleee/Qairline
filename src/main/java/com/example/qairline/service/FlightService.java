package com.example.qairline.service;

import com.example.qairline.dto.request.FlightRequest;
import com.example.qairline.dto.response.AircraftResponse;
import com.example.qairline.dto.response.FlightResponse;
import com.example.qairline.dto.response.UserResponse;
import com.example.qairline.model.Aircraft;
import com.example.qairline.model.Flight;
import com.example.qairline.repository.AircraftRepository;
import com.example.qairline.repository.FlightRepository;
import com.example.qairline.repository.TicketRepository;
import jakarta.persistence.ManyToOne;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class FlightService {
    @Autowired
    private FlightRepository flightRepository;
    @Autowired
    private AircraftRepository aircraftRepository;
    @Autowired
    private TicketRepository ticketRepository;

    public FlightResponse getFlightById(long id) {
        return convertToDTO(flightRepository.findById(id));
    }

    public List<FlightResponse> getAllFlights() {
        List<FlightResponse> flights = flightRepository.findAll().stream().map(this::convertToDTO).toList();
        return flights;
    }


    public Page<FlightResponse> getAllFlightsPaging(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<Flight> flights = flightRepository.findAll(pageable);
        return flights.map(this::convertToDTO);
    }

    public void deleteFlight(@RequestParam Long flightId) {
        flightRepository.deleteById(flightId);
    }

    public FlightResponse addFlight(FlightRequest request) {
        Flight flight = new Flight();

        flight.setAircraft(aircraftRepository.findByModel(request.getAircraftModel()));
        flight.setDeparture(request.getDeparture());
        flight.setDestination(request.getDestination());
        flight.setDepartureTime(request.getDepartureTime());
        flight.setTicketPrice(request.getTicketPrice());

        try {
            flight = flightRepository.save(flight);
        } catch (DataIntegrityViolationException exception) {
//            throw new AppException(ErrorCode.USER_EXISTED);
        }

        FlightResponse flightResponse = convertToDTO(flight);
        return flightResponse;
    }

    public FlightResponse editFlight(Long flightId, FlightRequest flightRequest) {
        Flight flight = flightRepository.findById(flightId).get();
        flight.setAircraft(aircraftRepository.findByModel(flightRequest.getAircraftModel()));
        flight.setDeparture(flightRequest.getDeparture());
        flight.setDestination(flightRequest.getDestination());
        flight.setDepartureTime(flightRequest.getDepartureTime());
        flight.setTicketPrice(flightRequest.getTicketPrice());
        try {
            flight = flightRepository.save(flight);
        } catch (DataIntegrityViolationException exception) {
//            throw new AppException(ErrorCode.USER_EXISTED);
        }

        FlightResponse flightResponse = convertToDTO(flight);
        return flightResponse;
    }

    public Page<FlightResponse> searchFlights(String keyword, int page, int size) {
        PageRequest pageRequest = PageRequest.of(page, size);
        return flightRepository.searchByKeyword(keyword, pageRequest).map(this::convertToDTO);
    }

    private FlightResponse convertToDTO(Flight flight) {
        return new FlightResponse(flight.getFlightId(), flight.getAircraft().getModel(), flight.getDeparture(), flight.getDestination(), flight.getDepartureTime(), flight.getTicketPrice(), ticketRepository.findByFlightAndUserIsNull(flight).stream().count());
    }
}
