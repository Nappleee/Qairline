package com.example.qairline.dto.response;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class LoginDTO {
    @NotBlank(message = "Username Không Được Để Trống")
    private String username;
    @NotBlank(message = "Password Không Được Để Trống")
    private String password;

}
