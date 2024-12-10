package com.example.qairline.service;

import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.jwt.JwtDecoder;

public class JwtTokenService {

    private final JwtDecoder jwtDecoder;

    public JwtTokenService(JwtDecoder jwtDecoder) {
        this.jwtDecoder = jwtDecoder;
    }

    // Phương thức kiểm tra role
    public boolean checkRoleInToken(String token, String expectedRole) {
        Jwt jwt = jwtDecoder.decode(token);  // Giải mã token
        String role = jwt.getClaim("role");  // Lấy giá trị role từ token

        return expectedRole.equals(role);  // Kiểm tra nếu role khớp
    }
}

