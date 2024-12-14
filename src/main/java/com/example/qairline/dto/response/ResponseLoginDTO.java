package com.example.qairline.dto.response;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ResponseLoginDTO {
    private String accessToken;
    private Long user_id;
    public String getAccessToken() {
        return accessToken;
    }

    public void setAccessToken(String accessToken) {
        this.accessToken = accessToken;
    }

    // Getter and Setter cho user_id
    public Long getUserId() {
        return user_id;
    }

    public void setUserId(Long userId) {
        this.user_id = userId;
    }
}
