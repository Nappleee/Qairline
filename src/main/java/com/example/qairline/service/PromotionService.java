package com.example.qairline.service;

import com.example.qairline.dto.request.PromotionRequest;
import com.example.qairline.dto.response.PromotionResponse;
import com.example.qairline.model.Promotion;
import com.example.qairline.repository.PromotionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class PromotionService {
    @Autowired
    PromotionRepository promotionRepository;

    public PromotionResponse getPromotionById(long id) {
        return convertToDTO(promotionRepository.findById(id));
    }

    public List<PromotionResponse> getAllPromotions() {
        List<PromotionResponse> promotions = promotionRepository.findAll().stream().map(this::convertToDTO).toList();
        return promotions;
    }


    public Page<PromotionResponse> getAllPromotionsPaging(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<Promotion> promotions = promotionRepository.findAll(pageable);
        return promotions.map(this::convertToDTO);
    }

    public void deletePromotion(@RequestParam Long Id) {
        promotionRepository.deleteById(Id);
    }

    public PromotionResponse addPromotion(PromotionRequest request) {
        Promotion promotion = new Promotion();

        promotion.setDescription(request.getDescription());
        promotion.setDiscountPercent(request.getDiscountPercent());
        promotion.setStartDate(request.getStartDate());
        promotion.setEndDate(request.getEndDate());

        try {
            promotion = promotionRepository.save(promotion);
        } catch (DataIntegrityViolationException exception) {
//            throw new AppException(ErrorCode.USER_EXISTED);
        }
        return convertToDTO(promotion);
    }

    public PromotionResponse updatePromotion(Long Id, PromotionRequest request) {
        Promotion promotion = promotionRepository.findById(Id).get();

        promotion.setDescription(request.getDescription());
        promotion.setDiscountPercent(request.getDiscountPercent());
        promotion.setStartDate(request.getStartDate());
        promotion.setEndDate(request.getEndDate());
        try {
            promotion = promotionRepository.save(promotion);
        } catch (DataIntegrityViolationException exception) {
//            throw new AppException(ErrorCode.USER_EXISTED);
        }

        return convertToDTO(promotion);
    }

    public Page<PromotionResponse> searchPromotions(String keyword, int page, int size) {
        PageRequest pageRequest = PageRequest.of(page, size);
        return promotionRepository.searchByKeyword(keyword, pageRequest).map(this::convertToDTO);
    }

    public List<PromotionResponse> getActivePromotions() {
        LocalDateTime now = LocalDateTime.now();
        return promotionRepository.findByStartDateBeforeAndEndDateAfter(now, now).stream().map(promotion -> convertToDTO(promotion)).toList();
    }

    public PromotionResponse convertToDTO(Promotion promotion) {
        return new PromotionResponse(promotion.getPromotionId(), promotion.getDescription(), promotion.getDiscountPercent(), promotion.getStartDate(), promotion.getEndDate());
    }
}
