package com.example.qairline.dto.response;

import jakarta.persistence.Column;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class AnnouncementResponse {
    private Long announcementId;

    private String title;

    private String content;

    private String createdAt;

    private String updatedAt;

    public AnnouncementResponse(Long announcementId, String title, String content, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.announcementId = announcementId;
        this.title = title;
        this.content = content;
        this.createdAt = formatDateTime(createdAt);
        this.updatedAt = formatDateTime(updatedAt);
    }

    private String formatDateTime(LocalDateTime dateTime) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'<br>'HH:mm:ss");
        return dateTime.format(formatter);
    }
}
