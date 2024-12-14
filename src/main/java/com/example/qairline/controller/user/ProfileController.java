package com.example.qairline.controller.user;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ProfileController {

    @GetMapping("/myprofile")
    public String showMyProfile(Model model) {
        // Add any attributes to the model if needed
        model.addAttribute("username", "Current User"); // Example data
        return "user/myprofile"; // Corresponds to myprofile.jsp
    }
}