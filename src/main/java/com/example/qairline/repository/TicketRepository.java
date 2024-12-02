package com.example.qairline.repository;

import com.example.qairline.model.Ticket;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface TicketRepository extends JpaRepository<Ticket, Long> {
    List<Ticket> findAll();
    Page<Ticket> findAll(Pageable pageable);
    void deleteById(Long id);
    Ticket findById(long id);
    @Query("SELECT t FROM Ticket t WHERE " +
            "t.user.username LIKE %:keyword% OR " +
            "t.status LIKE %:keyword% OR " +
            "t.seatNumber LIKE %:keyword%")
    Page<Ticket> searchByKeyword(String keyword, Pageable pageable);
}
