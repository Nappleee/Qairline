package com.example.qairline.repository;

import com.example.qairline.dto.response.FlightResponse;
import com.example.qairline.model.Flight;
import com.example.qairline.model.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FlightRepository extends JpaRepository<Flight, Long> {
    List<Flight> findAll();
    Page<Flight> findAll(Pageable pageable);
    void deleteById(Long id);
    Flight findById(long id);

    @Query("SELECT f FROM Flight f WHERE " +
            "f.aircraft.model LIKE %:keyword% OR " +
            "f.departure LIKE %:keyword% OR " +
            "f.destination LIKE %:keyword%")
    Page<Flight> searchByKeyword(String keyword, Pageable pageable);

}
