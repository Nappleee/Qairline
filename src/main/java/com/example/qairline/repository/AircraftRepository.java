package com.example.qairline.repository;

import com.example.qairline.model.Aircraft;
import com.example.qairline.model.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface AircraftRepository extends JpaRepository<Aircraft, Long> {
    List<Aircraft> findAll();
    Page<Aircraft> findAll(Pageable pageable);
    Aircraft findByModel(String model);
    void deleteByModel(String model);

    @Query("SELECT a FROM Aircraft a WHERE " +
            "a.model LIKE %:keyword%")
    Page<Aircraft> searchByKeyword(String keyword, Pageable pageable);
}
