package com.example.qairline.service;

import com.example.qairline.dto.request.AnnouncementRequest;
import com.example.qairline.dto.response.AircraftResponse;
import com.example.qairline.dto.response.AnnouncementResponse;
import com.example.qairline.model.Announcement;
import com.example.qairline.repository.AnnouncementRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AnnouncementService {
    @Autowired
    private AnnouncementRepository announcementRepository;

    public List<AnnouncementResponse> getAllAnnouncement() {
        return announcementRepository.findAll().stream().map(this::convertToDTO).toList();
    }

    public Page<AnnouncementResponse> getAllAnnouncementPaging(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return announcementRepository.findAll(pageable).map(this::convertToDTO);
    }

    public AnnouncementResponse getAnnouncementById(long id) {

        return convertToDTO(announcementRepository.findById(id));
    }

    public Page<AnnouncementResponse> searchAnnouncements(String keyword, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return announcementRepository.findByKeyword(keyword, pageable).map(this::convertToDTO);
    }

    public AnnouncementResponse addAnnouncement(AnnouncementRequest request) {
        Announcement announcement = new Announcement();
        announcement.setContent(request.getContent());
        announcement.setTitle(request.getTitle());
        announcementRepository.save(announcement);
        return convertToDTO(announcement);
    }

    public AnnouncementResponse updateAnnouncement(Long id, AnnouncementRequest request) {
        Announcement announcement = announcementRepository.findById(id).get();
        announcement.setContent(request.getContent());
        announcement.setTitle(request.getTitle());
        announcementRepository.save(announcement);
        return convertToDTO(announcement);
    }

    public void deleteAnnouncement(Long id) {
        announcementRepository.deleteById(id);
    }

    private AnnouncementResponse convertToDTO(Announcement announcement) {
        return new AnnouncementResponse(announcement.getAnnouncementId(), announcement.getTitle(), announcement.getContent(), announcement.getCreatedAt(), announcement.getUpdatedAt());
    }
}
