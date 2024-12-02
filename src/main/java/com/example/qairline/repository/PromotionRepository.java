package com.example.qairline.repository;

import com.example.qairline.model.Flight;
import com.example.qairline.model.Promotion;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDateTime;
import java.util.List;

public interface PromotionRepository extends JpaRepository<Promotion, Long> {
    List<Promotion> findAll();
    Page<Promotion> findAll(Pageable pageable);
    void deleteById(Long id);
    Promotion findById(long id);
    List<Promotion> findByStartDateBeforeAndEndDateAfter(LocalDateTime startDate, LocalDateTime endDate);


    @Query("SELECT p FROM Promotion p WHERE " +
            "p.description LIKE %:keyword%")
    Page<Promotion> searchByKeyword(String keyword, Pageable pageable);
}
