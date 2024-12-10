//package com.example.qairline.config;
//
//
//import jakarta.servlet.*;
//import jakarta.servlet.annotation.WebFilter;
//import jakarta.servlet.http.HttpServletRequest;
//
//import java.io.IOException;
//
//@WebFilter("/*")  // Hoặc có thể chỉ định URL cụ thể để filter
//public class TokenFilter implements Filter {
//
//    @Override
//    public void init(FilterConfig filterConfig) throws ServletException {
//        // Khởi tạo nếu cần thiết
//    }
//
//    @Override
//    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
//            throws IOException, ServletException {
//        HttpServletRequest httpRequest = (HttpServletRequest) request;
//
//        // Tạo hoặc lấy token từ đâu đó
//        String token = httpRequest.getHeader("Authorization");; // Bạn có thể lấy từ header, cookie, hoặc tạo mới
//
//        // Đặt token vào request để controller có thể lấy
//        httpRequest.setAttribute("token", token); // Hoặc set vào header nếu cần thiết
//
//        // Tiến hành chain tiếp theo
//        chain.doFilter(request, response);
//    }
//
//    @Override
//    public void destroy() {
//        // Xử lý khi filter bị hủy
//    }
//}
