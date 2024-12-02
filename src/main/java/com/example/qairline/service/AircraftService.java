package com.example.qairline.service;

import com.example.qairline.dto.request.AircraftRequest;
import com.example.qairline.dto.response.AircraftResponse;
import com.example.qairline.dto.response.FlightResponse;
import com.example.qairline.dto.response.UserResponse;
import com.example.qairline.model.Aircraft;
import com.example.qairline.repository.AircraftRepository;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AircraftService {
    @Autowired
    private AircraftRepository aircraftRepository;

    public List<AircraftResponse> getAllAircrafts() {
        List<AircraftResponse> aircraftResponses=aircraftRepository.findAll().stream().map(this::convertToDTO).toList();
        return aircraftResponses;
    }

    public Page<AircraftResponse> getAllAircraftsPaging(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return aircraftRepository.findAll(pageable).map(this::convertToDTO);
    };


    public AircraftResponse convertToDTO(Aircraft aircraft) {
        return new AircraftResponse(aircraft.getAircraftId(), aircraft.getModel(), aircraft.getCapacity());
    }

    public AircraftResponse createAircraft(AircraftRequest request) {
        Aircraft aircraft = new Aircraft();

        if (aircraftRepository.findByModel(request.getModel()) != null) {
            return null;
        }

        aircraft.setModel(request.getModel());
        aircraft.setCapacity(request.getCapacity());


        try {
            aircraft = aircraftRepository.save(aircraft);
        } catch (DataIntegrityViolationException exception) {
//            throw new AppException(ErrorCode.USER_EXISTED);
        }

        AircraftResponse aircraftResponse = new AircraftResponse();
        aircraftResponse.setModel(aircraft.getModel());
        aircraftResponse.setCapacity(aircraft.getCapacity());

        return aircraftResponse;
    }

    public void deleteAircraft(String model) {
        aircraftRepository.deleteByModel(model);
    }

    public Page<AircraftResponse> searchAircrafts(String keyword, int page, int size) {
        PageRequest pageRequest = PageRequest.of(page, size);
        return aircraftRepository.searchByKeyword(keyword, pageRequest).map(this::convertToDTO);
    }
}
