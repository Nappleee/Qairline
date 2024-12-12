package com.example.qairline.config;

import com.example.qairline.model.User;
import com.example.qairline.repository.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.experimental.NonFinal;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.HashSet;

@Configuration
@EnableMethodSecurity(securedEnabled = true)
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class ApplicationInitConfig {

    PasswordEncoder passwordEncoder;

    @NonFinal
    static final String ADMIN_USER_NAME = "admin";

    @NonFinal
    static final String ADMIN_PASSWORD = "admin";

    @Bean
    ApplicationRunner applicationRunner(UserRepository userRepository) {
        log.info("Initializing application.....");
        log.info("Initializing application...");

        return args -> {
            // Kiểm tra xem đã có tài khoản admin chưa
            if (userRepository.findByUsername(ADMIN_USER_NAME) == null) {
                // Tạo tài khoản admin với mật khẩu đã mã hóa
                User user = User.builder()
                        .username(ADMIN_USER_NAME)
                        .password(passwordEncoder.encode(ADMIN_PASSWORD))  // Mã hóa mật khẩu
                        .email("datlc81@gmail.com")
                        .role("ADMIN")  // Gán vai trò "ADMIN" cho tài khoản này
                        .build();

                userRepository.save(user);
                log.warn("Admin user has been created with default password: admin, please change it.");
            }
            log.info("Application initialization completed.");
        };
    }
}
