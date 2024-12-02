package com.example.qairline.repository;

import com.example.qairline.model.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    List<User> findAll();
    User findById(long id);
    Page<User> findAll(Pageable pageable);
    User findByUsername(String username);

    @Query("SELECT u FROM User u WHERE " +
            "u.fullName LIKE %:keyword% OR " +
            "u.username LIKE %:keyword% OR " +
            "u.email LIKE %:keyword% OR " +
            "u.phoneNumber LIKE %:keyword% OR " +
            "u.address LIKE %:keyword%")
    Page<User> searchByKeyword(String keyword, Pageable pageable);
}
