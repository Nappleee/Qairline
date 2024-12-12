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
public class PromotionResponse {
    private Long promotionId;
    private String title;
    private String description;
    private Double discountPercent;
    private String startDate;
    private String endDate;

    public PromotionResponse(Long promotionId,String title, String description, Double discountPercent, LocalDateTime startDate, LocalDateTime endDate) {
        this.promotionId = promotionId;
        this.title = title;
        this.description = description;
        this.discountPercent = discountPercent;
        this.startDate = formatDateTime(startDate);
        this.endDate = formatDateTime(endDate);
    }

    private String formatDateTime(LocalDateTime dateTime) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'<br>'HH:mm:ss");
        return dateTime.format(formatter);
    }
}
