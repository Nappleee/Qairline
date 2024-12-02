package com.example.qairline.repository;

import com.example.qairline.model.Announcement;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AnnouncementRepository extends JpaRepository<Announcement, Long> {
    List<Announcement> findAll();
    Page<Announcement> findAll(Pageable pageable);
    void deleteById(Long id);
    Announcement findById(long id);

    @Query("SELECT a FROM Announcement a WHERE " +
            "a.title LIKE %:keyword% OR " +
            "a.content LIKE %:keyword%")
    Page<Announcement> findByKeyword(@Param("keyword") String keyword, Pageable pageable);
}
