package com.example.qairline.service;

import com.example.qairline.dto.request.FlightRequest;
import com.example.qairline.dto.request.UserRequest;
import com.example.qairline.dto.response.FlightResponse;
import com.example.qairline.dto.response.UserResponse;
import com.example.qairline.model.Flight;
import com.example.qairline.model.User;
import com.example.qairline.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class UserService {
    @Autowired
    UserRepository userRepository;
    @Autowired
    PasswordEncoder passwordEncoder;

    public List<UserResponse> getAllUsers() {
        return userRepository.findAll().stream().map(this::convertToDTO).toList();
    }

    public Page<UserResponse> getAllUsers(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return userRepository.findAll(pageable).map(this::convertToDTO);
    }

    public Page<UserResponse> searchUsers(String keyword, int page, int size) {
        PageRequest pageRequest = PageRequest.of(page, size);
        return userRepository.searchByKeyword(keyword, pageRequest).map(this::convertToDTO);
    }

    public UserResponse convertToDTO(User user) {
        return new UserResponse(
                user.getUserId(),  // Kiểm tra null và gán giá trị mặc định nếu cần
                user.getFullName() != null ? user.getFullName() : user.getUsername(),  // Kiểm tra null cho tên đầy đủ
                user.getUsername() != null ? user.getUsername() : "null",  // Kiểm tra null cho tên người dùng
                user.getEmail() != null ? user.getEmail() : "null",  // Kiểm tra null cho email
                user.getPhoneNumber() != null ? user.getPhoneNumber() : "null",  // Kiểm tra null cho số điện thoại
                user.getAddress() != null ? user.getAddress() : "null",  // Kiểm tra null cho địa chỉ
                user.getRole() != null ? user.getRole() : "CUSTOMER",  // Kiểm tra null cho vai trò
                user.getCreatedAt() != null ? user.getCreatedAt() : LocalDateTime.now()  // Kiểm tra null cho ngày tạo
        );
    }

    public User handleCreateUser(User user) {
        return this.userRepository.save(user);
    }

    public UserResponse addUser(UserRequest request) {
        User user = new User();
        String hashPassword = this.passwordEncoder.encode(request.getPassword());
        user.setFullName(request.getFullName());
        user.setUsername(request.getUsername());
        user.setEmail(request.getEmail());
        user.setPhoneNumber(request.getPhoneNumber());
        user.setAddress(request.getAddress());
        user.setCreatedAt(LocalDateTime.now());
        user.setPassword(hashPassword);
        if (request.getRole() == null) {
            user.setRole("CUSTOMER");
        } else {
            user.setRole(request.getRole());
        }
        return this.convertToDTO(this.userRepository.save(user));
    }

    public UserResponse editUser(Long id, UserRequest request) {
        User user = this.userRepository.findById(id).orElse(null);
        user.setFullName(request.getFullName());
        user.setUsername(request.getUsername());
        user.setEmail(request.getEmail());
        user.setPhoneNumber(request.getPhoneNumber());
        user.setAddress(request.getAddress());
        user.setCreatedAt(LocalDateTime.now());
        user.setPassword(passwordEncoder.encode(request.getPassword()));
        return this.convertToDTO(this.userRepository.save(user));
    }
}
