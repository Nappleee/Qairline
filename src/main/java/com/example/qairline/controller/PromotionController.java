package com.example.qairline.controller;

import com.example.qairline.dto.request.PromotionRequest;
import com.example.qairline.dto.response.PromotionResponse;
import com.example.qairline.service.PromotionService;
import com.example.qairline.util.SecurityUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping
public class PromotionController {
    @Autowired
    private PromotionService promotionService;
    @Autowired
    private SecurityUtil securityUtil;
    @Autowired
    AuthController authController;

    @Transactional
    @GetMapping("/api/promotions")
    @ResponseBody
    public Page<PromotionResponse> getAllPromotions(@RequestHeader("Authorization") String authorizationHeader, @RequestParam(defaultValue = "0") int page,
                                                 @RequestParam(defaultValue = "5") int size) {
        if (isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            return promotionService.getAllPromotionsPaging(page, size);
        }
        return null;
    }

    @GetMapping("/home")
    public String Lmao(){
        return "user/home";
    }


    @GetMapping("api/promotionsSearch")
    @ResponseBody
    public Page<PromotionResponse> getPromotionsSearch(@RequestHeader("Authorization") String authorizationHeader, @RequestParam String keyword, @RequestParam int page, @RequestParam int size) {
        if (isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            return promotionService.searchPromotions(keyword, page, size);

        }
        return null;
    }

    @GetMapping("/api/getAllPromotions")
    @ResponseBody
    public List<PromotionResponse> getAllPromotions(@RequestHeader("Authorization") String authorizationHeader) {
        if (isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            return promotionService.getAllPromotions();
        }
        return null;
    };

    @GetMapping("/admin/promotions")
    public String getPromotions(Model model) {
        model.addAttribute("promotionsCount", promotionService.getAllPromotions().stream().count());
        model.addAttribute("pageCount", (promotionService.getAllPromotions().stream().count() + 4) / 5);

        return "admin/promotions";
    }

    @PostMapping("/api/deletepromotion")
    @ResponseBody
    public String deletePromotion(@RequestHeader("Authorization") String authorizationHeader, @RequestParam("promotionId") Long promotionId) {
        if (isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            promotionService.deletePromotion(promotionId);
            return "success";
        }
        return null;
    }

    @PostMapping("/admin/addpromotions")
    @ResponseBody
    public String addPromotion(@RequestHeader("Authorization") String authorizationHeader, @ModelAttribute("addPromotionModelAttribute") PromotionRequest request, RedirectAttributes redirectAttributes) {
        if (isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            promotionService.addPromotion(request);
            return "success";
        }
        return null;
    }

    @GetMapping("/api/promotions/{promotionId}")
    @ResponseBody
    public PromotionResponse getPromotionById(@RequestHeader("Authorization") String authorizationHeader, @PathVariable Long promotionId) {
        if (isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            return promotionService.getPromotionById(promotionId);
        }
        return null;
    }


    @PutMapping("/api/promotions/{promotionId}")
    @ResponseBody
    public PromotionResponse updatePromotion(@RequestHeader("Authorization") String authorizationHeader, @PathVariable Long promotionId, @RequestBody PromotionRequest request) {
        if (isAdmin() && !authController.isTokenBlacklisted(authorizationHeader)) {
            return promotionService.updatePromotion(promotionId, request);
        }
        return null;
    }

    boolean isAdmin() {
        String userName = securityUtil.getCurrentUserLogin().orElse(null);
        if (userName != null && userName.equals("admin")) {
            return true;
        }
        return false;
    }
}
