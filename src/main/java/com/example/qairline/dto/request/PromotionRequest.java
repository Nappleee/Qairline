package com.example.qairline.dto.request;

import jakarta.validation.constraints.NotEmpty;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class PromotionRequest {
    @NotEmpty
    private String title;
    @NotEmpty
    private String description;
    @NotEmpty
    private Double discountPercent;
    @NotEmpty
    private LocalDateTime startDate;
    @NotEmpty
    private LocalDateTime endDate;
}
