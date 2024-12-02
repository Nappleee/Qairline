package com.example.qairline.dto.response;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class UserResponse {
    private Long userId;
    private String fullName;
    private String username;
    private String email;
    private String phoneNumber;
    private String address;
    private String role;
    private String createdAt;

    public UserResponse(Long userId, String fullName, String username, String email, String phoneNumber, String address, String role, LocalDateTime createdAt) {
        this.userId = userId;
        this.fullName = fullName;
        this.username = username;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.role = role;
        this.createdAt = formatDateTime(createdAt);
    }

    private String formatDateTime(LocalDateTime dateTime) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'<br>'HH:mm:ss");
        return dateTime.format(formatter);
    }
}
