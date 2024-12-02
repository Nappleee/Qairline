package com.example.qairline.service;

import com.example.qairline.dto.response.UserResponse;
import com.example.qairline.model.User;
import com.example.qairline.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {
    @Autowired
    UserRepository userRepository;

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
        return new UserResponse(user.getUserId(),
                user.getFullName(),
                user.getUsername(),
                user.getEmail(),
                user.getPhoneNumber(),
                user.getAddress(),
                user.getRole(),
                user.getCreatedAt());
    }
}
