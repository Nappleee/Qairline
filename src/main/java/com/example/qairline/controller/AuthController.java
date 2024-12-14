package com.example.qairline.controller;

import com.example.qairline.dto.response.LoginDTO;
import com.example.qairline.dto.response.ResponseLoginDTO;
import com.example.qairline.service.UserService;
import com.example.qairline.util.JwtTokenBlacklist;
import com.example.qairline.util.SecurityUtil;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import com.example.qairline.model.User;
import com.example.qairline.repository.UserRepository;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

@Controller
@RequestMapping
public class AuthController {
    private final AuthenticationManagerBuilder authenticationManagerBuilder;
    private final SecurityUtil securityUtil;
    @Autowired
    private UserService userService;
    private Set<String> blacklistedTokens = ConcurrentHashMap.newKeySet();

    String accessToken;

    public AuthController(AuthenticationManagerBuilder authenticationManagerBuilder, SecurityUtil securityUtil) {
        this.authenticationManagerBuilder = authenticationManagerBuilder;
        this.securityUtil = securityUtil;
    }

    @GetMapping("/admin/login")
    public String homeAdmin() {
        return "admin/login";
    }

    @PostMapping("/admin/loginnn")
    @ResponseBody
    public ResponseEntity<ResponseLoginDTO> loginAdmin(@Valid @RequestBody LoginDTO loginDTO) {
        // Nạp input gồm username/password vào Security
        UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(loginDTO.getUsername(), loginDTO.getPassword());

        // Xác thực người dùng
        Authentication authentication = authenticationManagerBuilder.getObject().authenticate(authenticationToken);

        String role = authentication.getAuthorities().iterator().next().getAuthority();
        // Lấy quyền từ authentication (ở đây chỉ có 1 quyền duy nhất)
        accessToken = this.securityUtil.createToken(authentication);



        if (role.equals("ROLE_ADMIN") || role.equals("ROLE_USER")) {
            ResponseLoginDTO responseLoginDTO = new ResponseLoginDTO();
            responseLoginDTO.setAccessToken(accessToken);

            // Lưu thông tin vào SecurityContext
            SecurityContextHolder.getContext().setAuthentication(authentication);

            return ResponseEntity.ok().body(responseLoginDTO);
        }
        // Tạo DTO chứa token và quyền
        return null;
    }

    @PostMapping("/loginnn")
    @ResponseBody
    public ResponseEntity<ResponseLoginDTO> login(@Valid @RequestBody LoginDTO loginDTO) {
        // Nạp input gồm username/password vào Security
        UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(loginDTO.getUsername(), loginDTO.getPassword());

        // Xác thực người dùng
        Authentication authentication = authenticationManagerBuilder.getObject().authenticate(authenticationToken);

        String role = authentication.getAuthorities().iterator().next().getAuthority();
        // Lấy quyền từ authentication (ở đây chỉ có 1 quyền duy nhất)
        accessToken = this.securityUtil.createToken(authentication);


        // Lấy user_id từ cơ sở dữ liệu
        String username = authentication.getName(); // Lấy username từ authentication

        Long userId = userService.getUserIdByUserName(username);

        ResponseLoginDTO responseLoginDTO = new ResponseLoginDTO();
        responseLoginDTO.setAccessToken(accessToken);
        responseLoginDTO.setUserId(userId);
        // Lưu thông tin vào SecurityContext
        SecurityContextHolder.getContext().setAuthentication(authentication);

            return ResponseEntity.ok().body(responseLoginDTO);
    }

    @PostMapping("/admin/logout")
    @ResponseBody
    public ResponseEntity<String> logout(@RequestHeader("Authorization") String authorizationHeader) {
        // Kiểm tra xem có token trong header không
        if (authorizationHeader == null || !authorizationHeader.startsWith("Bearer ")) {
            return ResponseEntity.badRequest().body("Token không hợp lệ");
        }

        // Lấy token từ Authorization header
        String token = authorizationHeader.substring(7); // Loại bỏ "Bearer " khỏi token

        // Thêm token vào blacklist
        addToBlacklist(token);

        // Hủy SecurityContext (logout khỏi Spring Security)
        SecurityContextHolder.clearContext();

        return ResponseEntity.ok("Đăng xuất thành công");
    }

    // Thêm token vào blacklist
    public void addToBlacklist(String token) {
        blacklistedTokens.add(token);
    }

    // Kiểm tra xem token có trong blacklist không
    public boolean isTokenBlacklisted(String token) {

        return blacklistedTokens.contains(token.substring(7));
    }

    // Xóa token khỏi blacklist (nếu cần)
    public void removeFromBlacklist(String token) {
        blacklistedTokens.remove(token);
    }
}
