<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Topbar Update</title>
    <style>
        /* Tổng quan về topbar */
        .topbar-user {
            position: relative;
            display: inline-block;
            font-family: Arial, sans-serif;
        }

        /* Nút dropdown */
        .dropdown-btn {
            background: none;
            border: none;
            color: #ffffff;
            font-size: 16px;
            cursor: pointer;
            padding: 8px 15px;
            border-radius: 5px;
            transition: all 0.3s ease;
            display: inline-block;
        }

        .dropdown-btn:hover {
            background-color: rgba(255, 255, 255, 0.1);
            transform: scale(1.1);
            color: #ffd700; /* Màu khi hover vào nút */
        }

        /* Nội dung dropdown */
        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #333;
            min-width: 160px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
            z-index: 1;
            border-radius: 10px;
            opacity: 0;
            visibility: hidden;
            transform: translateY(-10px);
            transition: opacity 0.3s ease, transform 0.3s ease, visibility 0.3s;
        }

        .dropdown-content a {
            color: white;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            font-size: 14px;
            border-bottom: 1px solid #444;
            transition: background-color 0.3s ease;
            border-radius: 5px;
        }

        .dropdown-content a:hover {
            background-color: #575757;
            transform: scale(1.05);
        }

        /* Hiển thị dropdown khi hover */
        .dropdown:hover .dropdown-content {
            display: block;
            opacity: 1;
            visibility: visible;
            transform: translateY(0);
        }

        /* Hiệu ứng khi phần tử được hover */
        .topbar-user small {
            font-size: 18px;
            transition: color 0.3s ease;
        }

        .topbar-user small:hover {
            color: #ffd700;
        }

    </style>
</head>
<body>
<div class="custom-link">
    <!-- Phần topbar sẽ được cập nhật bằng JavaScript -->
</div>

<script>
    function updateTopbar(username) {
        const topbar = document.getElementById('.custom-link').parentElement;
        topbar.innerHTML = `
                <div class="topbar-user">
                    <small class="me-3 text-light">Hello, ${username}</small>
                    <div class="dropdown">
                        <button class="dropdown-btn">▼</button>
                        <div class="dropdown-content">
                            <a href="/manage-flights">Quản lý các chuyến bay</a>
                            <a href="/logout">Đăng xuất</a>
                        </div>
                    </div>
                </div>
            `;
    }
    document.addEventListener("DOMContentLoaded", () => {
        const currentUser = localStorage.getItem("currentUser");
        if (currentUser) {
            updateTopbar(currentUser);
        }
    });
    // Ví dụ sử dụng:
</script>
</body>
</html>
