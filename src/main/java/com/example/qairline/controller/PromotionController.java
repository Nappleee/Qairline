package com.example.qairline.controller;

import com.example.qairline.dto.request.PromotionRequest;
import com.example.qairline.dto.response.PromotionResponse;
import com.example.qairline.service.PromotionService;
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

    @Transactional
    @GetMapping("/api/promotions")
    @ResponseBody
    public Page<PromotionResponse> getAllPromotions(@RequestParam(defaultValue = "0") int page,
                                                 @RequestParam(defaultValue = "5") int size) {
        return promotionService.getAllPromotionsPaging(page, size);
    }

    @GetMapping("/home")
    public String Lmao(){
        return "user/home";
    }

    @GetMapping("api/promotionsSearch")
    @ResponseBody
    public Page<PromotionResponse> getPromotionsSearch(@RequestParam String keyword, @RequestParam int page, @RequestParam int size) {

        return promotionService.searchPromotions(keyword, page, size);
    }

    @GetMapping("/api/getAllPromotions")
    @ResponseBody
    public List<PromotionResponse> getAllPromotions() {
        return promotionService.getAllPromotions();
    };

    @GetMapping("/admin/promotions")
    public String getPromotions(Model model) {
        model.addAttribute("promotionsCount", promotionService.getAllPromotions().stream().count());
        model.addAttribute("pageCount", (promotionService.getAllPromotions().stream().count() + 4) / 5);

        return "admin/promotions";
    }

    @PostMapping("/api/deletepromotion")
    @ResponseBody
    public String deletePromotion(@RequestParam("promotionId") Long promotionId) {
        promotionService.deletePromotion(promotionId);
        return "success";
    }

    @PostMapping("/admin/promotions")
    @ResponseBody
    public String addAircraft(@ModelAttribute("addPromotionModelAttribute") PromotionRequest request, RedirectAttributes redirectAttributes) {
        promotionService.addPromotion(request);
        return "success";
    }

    @GetMapping("/api/promotions/{promotionId}")
    @ResponseBody
    public PromotionResponse getPromotionById(@PathVariable Long promotionId) {
        return promotionService.getPromotionById(promotionId);
    }


    @PutMapping("/api/promotions/{promotionId}")
    @ResponseBody
    public PromotionResponse updatePromotion(@PathVariable Long promotionId, @RequestBody PromotionRequest request) {
        return promotionService.updatePromotion(promotionId, request);
    }
}
