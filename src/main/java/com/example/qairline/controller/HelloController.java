package com.example.qairline.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import org.springframework.stereotype.Controller;
@Controller
public class HelloController {

    @GetMapping("/")
    public String userHome()  {
        return "user/home";
    }
    @GetMapping("/blog")
    public String blog()  {
        return "user/blog";
    }
    @GetMapping("/about")
    public String about()  {
        return "user/about";
    }
}

