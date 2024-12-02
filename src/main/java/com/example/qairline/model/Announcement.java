package com.example.qairline.model;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDateTime;

@Entity
@Table(name = "announcements")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Announcement {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long announcementId;

    private String title;

    @Column(columnDefinition = "TEXT")
    private String content;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    @PrePersist
    public void prePersist() {
        if (this.createdAt == null) {
            this.createdAt = LocalDateTime.now();  // Gán createdAt trước khi persist vào DB
        }
        if (this.updatedAt == null) {
            this.updatedAt = LocalDateTime.now();  // Gán updatedAt trước khi persist vào DB
        }
    }

    @PreUpdate
    public void preUpdate() {
        this.updatedAt = LocalDateTime.now(); // Cập nhật updatedAt mỗi khi có sự thay đổi
    }

//    @ManyToOne
//    @JoinColumn(name = "user_id", nullable = false)
//    private User user;

}
