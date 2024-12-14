package com.example.qairline.controller;

import com.example.qairline.dto.request.FlightRequest;
import com.example.qairline.dto.request.UserRequest;
import com.example.qairline.dto.response.AircraftResponse;
import com.example.qairline.dto.response.UserResponse;
import com.example.qairline.model.User;
import com.example.qairline.service.UserService;
import com.example.qairline.util.SecurityUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.HashMap;
import java.util.Map;
import java.util.List;

@Controller
@RequestMapping
public class UserController {
    @Autowired
    UserService userService;
    @Autowired
    PasswordEncoder passwordEncoder;
    @Autowired
    SecurityUtil securityUtil;
    @Autowired
    AuthController authController;


    @GetMapping("api/getAllUsers")
    @ResponseBody
    public List<UserResponse> getAllUsers(@RequestHeader("Authorization") String authorizationHeader) {
        if(isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            return userService.getAllUsers();
        }
         return null;
    }

    @GetMapping("api/users")
    @ResponseBody
    public Page<UserResponse> getAllAircrafts(@RequestHeader("Authorization") String authorizationHeader, @RequestParam int page, @RequestParam int size) {
        if(isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            return userService.getAllUsers(page, size);
        }
        return null;
    }

    @GetMapping("api/usersSearch")
    @ResponseBody
    public Page<UserResponse> getUsersSearch(@RequestHeader("Authorization") String authorizationHeader, @RequestParam String keyword, @RequestParam int page, @RequestParam int size) {
        if(isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            return userService.searchUsers(keyword, page, size);

        }
        return null;
    }

    @GetMapping("/admin/users")
    public String getUsers(Model model) {
        model.addAttribute("usersCount", userService.getAllUsers().stream().count());
        model.  addAttribute("pageCount", (userService.getAllUsers().stream().count() + 4) / 5);
        return "admin/users";
    }

    @PostMapping("/admin/addcustomer")
    @ResponseBody
    public String addUser(@RequestHeader("Authorization") String authorizationHeader, @ModelAttribute("userRequest") UserRequest request, RedirectAttributes redirectAttributes) {
        if (isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            userService.addUser(request);
            return "success";
        }
        return null;
    }

    @GetMapping("/admin/deny")
    public String deny(Model model) {
        return "admin/deny";
    }

    boolean isAdmin() {
        String userName = securityUtil.getCurrentUserLogin().orElse(null);
        if (userName != null && userName.equals("admin")) {
            return true;
        }
        return false;
    }

    @PostMapping("/register")
    @ResponseBody
    public ResponseEntity<Map<String, String>> registerUser(@RequestBody UserRequest request) {
        userService.addUser(request);
        Map<String, String> response = new HashMap<>();
        response.put("status", "success");
        return ResponseEntity.ok(response);  // Trả về JSON hợp lệ
    }

    public void someMethod(String username) {
        Long userId = userService.getUserIdByUserName(username);
        System.out.println("User ID: " + userId);
    }

}
