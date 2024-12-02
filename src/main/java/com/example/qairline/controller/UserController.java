package com.example.qairline.controller;

import com.example.qairline.dto.response.AircraftResponse;
import com.example.qairline.dto.response.UserResponse;
import com.example.qairline.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping
public class UserController {
    @Autowired
    UserService userService;

    @GetMapping("api/users")
    @ResponseBody
    public Page<UserResponse> getAllAircrafts(@RequestParam int page, @RequestParam int size) {
        return userService.getAllUsers(page, size);
    }

    @GetMapping("api/usersSearch")
    @ResponseBody
    public Page<UserResponse> getUsersSearch(@RequestParam String keyword, @RequestParam int page, @RequestParam int size) {

        return userService.searchUsers(keyword, page, size);
    }

    @GetMapping("/admin/users")
    public String getUsers(Model model) {
        model.addAttribute("usersCount", userService.getAllUsers().stream().count());
        model.addAttribute("pageCount", (userService.getAllUsers().stream().count() + 4) / 5);
        return "admin/users";
    }
}
