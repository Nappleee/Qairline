<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="icon" href="images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="/css/admin/login.css">
</head>

<body>
<div class="content">
    <form id="loginForm" class="form">
        <div class="header">
            Login
        </div>

        <div class="form-content">
            <div class="name-form-label">UserName</div>
            <input id="username" class="input-form" type="text" placeholder="Bui Bang">
            <span class="notice-message"></span>
        </div>


        <div class="form-content">
            <div class="name-form-label">Password</div>
            <input id="password" class="input-form" type="password" placeholder="Password">
            <span class="notice-message"></span>
        </div>

        <div id="loginError" class="notice-message">Invalid username or password.</div>

        <button class="form-submit">Login</button>
    </form>
</div>
<script src="/js/form.js"></script>
<script src="/libs/jquery/dist/jquery.min.js"></script>


<script>
    Validator({
        form: '#loginForm',
        formGroupSelector: '.form-content',
        errorSelector: '.notice-message',
        rules: [
            Validator.isRequired('#username', 'Please enter your username.'),
            Validator.isRequired('#password', 'Please enter your password.')
        ]
    })

    $(document).ready(function() {
        $('#loginError').hide();
        // Khi form đăng nhập được submit
        $("#loginForm").on("submit", function(event) {
            event.preventDefault(); // Ngừng gửi form theo cách truyền thống

            var username = $("#username").val();
            var password = $("#password").val();

            // Gửi dữ liệu qua AJAX
            $.ajax({
                url: '/admin/loginnn',  // URL của API đăng nhập
                method: 'POST',
                contentType: 'application/json',
                accept: 'application/json',
                data: JSON.stringify({
                    username: username,
                    password: password
                }),
                success: function(response) {
                    console.log(response);
                    // Lưu JWT Token vào localStorage
                    if (response === null) {
                        window.location.href = '/admin/deny';
                    } else {
                        localStorage.setItem("accessToken", response.accessToken);
                        //window.location.href = "/aircrafts.jsp";  // Điều hướng đến trang chính sau khi đăng nhập thành công
                        //
                        window.location.href = "/admin/aircrafts";
                    }

                },
                error: function(xhr, status, error) {
                    // Xử lý khi có lỗi
                    if (xhr.status === 401) {
                        // Nếu bị trả về 401, tức là người dùng chưa đăng nhập hoặc không có quyền
                        console.log('Unauthorized: Redirecting to login...');
                        //window.location.href = '/login';  // Chuyển hướng đến trang login
                        $('#loginError').show();
                    } else {
                        console.log('Lỗi: ', status, error);
                    }
                }
            });
        });
    });
</script>

</body>

</html>