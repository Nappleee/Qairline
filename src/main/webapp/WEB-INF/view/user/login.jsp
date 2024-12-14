<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login and Register Modal</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <style>

    </style>
</head>
<body>

<a href="#" data-bs-toggle="modal" data-bs-target="#authModal" class="custom-link" id="loginModal">
    <small class="me-3 text-light"><i class="fa fa-sign-in-alt me-2"></i>Đăng nhập</small>
</a>

<!-- Modal -->
<div class="modal fade" id="authModal" tabindex="-1" aria-labelledby="authModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="authModalLabel">Đăng nhập</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Login Form -->
                <form id="loginForm" method="post">
                    <div class="mb-3">
                        <label for="username" class="form-label">Tên đăng nhập</label>
                        <input type="text" class="form-control" id="username" name="username" placeholder="Nhập tên đăng nhập" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Mật khẩu</label>
                        <input type="password" class="form-control" id="password" name="password" placeholder="Nhập mật khẩu" required>
                    </div>
                    <div class="d-flex justify-content-between">
                        <button type="submit" class="btn btn-primary">Đăng nhập</button>
                        <a href="#" class="btn btn-link text-decoration-none" id="showRegisterForm">Đăng ký tài khoản</a>
                    </div>
                </form>

                <!-- Register Form -->
                <form id="registerForm" action="RegisterServlet" method="post" style="display: none;">
                    <div class="mb-3">
                        <label for="registerFullName" class="form-label">Họ và tên</label>
                        <input type="text" class="form-control" id="registerFullName" name="fullName" placeholder="Nhập họ và tên" required>
                    </div>
                    <div class="mb-3">
                        <label for="registerUsername" class="form-label">Tên đăng nhập</label>
                        <input type="text" class="form-control" id="registerUsername" name="username" placeholder="Nhập tên đăng nhập" required>
                    </div>
                    <div class="mb-3">
                        <label for="registerPassword" class="form-label">Mật khẩu</label>
                        <input type="password" class="form-control" id="registerPassword" name="password" placeholder="Nhập mật khẩu" required>
                    </div>
                    <div class="mb-3">
                        <label for="registerEmail" class="form-label">Email</label>
                        <input type="email" class="form-control" id="registerEmail" name="email" placeholder="Nhập email" required>
                    </div>
                    <div class="mb-3">
                        <label for="registerPhoneNumber" class="form-label">Số điện thoại</label>
                        <input type="text" class="form-control" id="registerPhoneNumber" name="phoneNumber" placeholder="Nhập số điện thoại" required>
                    </div>
                    <div class="mb-3">
                        <label for="registerAddress" class="form-label">Địa chỉ</label>
                        <input type="text" class="form-control" id="registerAddress" name="address" placeholder="Nhập địa chỉ" required>
                    </div>
                    <div class="mb-3">
                        <label for="registerRole" class="form-label">Vai trò</label>
                        <select class="form-control" id="registerRole" name="role">
                            <option value="CUSTOMER">Khách hàng</option>
                            <option value="ADMIN">Quản trị viên</option>
                        </select>
                    </div>
                    <div class="d-flex justify-content-between">
                        <button type="submit" class="btn btn-success">Đăng ký</button>
                        <a href="#" class="btn btn-link text-decoration-none" id="showLoginForm">Đăng nhập</a>
                    </div>
                </form>

            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const loginForm = document.getElementById('loginForm');
    const registerForm = document.getElementById('registerForm');
    const showRegisterForm = document.getElementById('showRegisterForm');
    const showLoginForm = document.getElementById('showLoginForm');

    // Switch between login and register forms
    showRegisterForm.addEventListener('click', (e) => {
        e.preventDefault();
        loginForm.style.display = 'none';
        registerForm.style.display = 'block';
    });

    showLoginForm.addEventListener('click', (e) => {
        e.preventDefault();
        registerForm.style.display = 'none';
        loginForm.style.display = 'block';
    });

    // Login form submission via AJAX
    loginForm.addEventListener('submit', function (e) {
        e.preventDefault(); // Prevent the default form submission

        const username = document.getElementById('username').value;
        const password = document.getElementById('password').value;
        const loginError = document.createElement('div');
        loginError.id = 'loginError';
        loginError.classList.add('text-danger', 'mt-2');

        // Clear previous error message
        const previousError = document.getElementById('loginError');
        if (previousError) {
            previousError.remove();
        }

        // Send login data via AJAX
        $.ajax({
            url: '/loginnn',  // URL của API đăng nhập
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
                    alert("ERROR")
                } else {

                    localStorage.setItem("accessToken", response.accessToken);
                    localStorage.setItem("username", username);
                    localStorage.setItem("user_id", response.user_id);
                    // Điều hướng đến trang chính sau khi đăng nhập thành công
                    window.location.href = "/";
                    // Cập nhật topbar
                }
            },
            error: function(xhr, status, error) {
                if (xhr.status === 401) {
                    alert('Failed Login');
                    $('#loginError').show();
                } else {
                    console.log('Lỗi: ', status, error);
                }
            }
        });
    });

    // Register form submission via AJAX
    registerForm.addEventListener('submit', function (e) {
        e.preventDefault();

        const fullName = document.getElementById('registerFullName').value;
        const username = document.getElementById('registerUsername').value;
        const password = document.getElementById('registerPassword').value;
        const email = document.getElementById('registerEmail').value;
        const phoneNumber = document.getElementById('registerPhoneNumber').value;
        const address = document.getElementById('registerAddress').value;
        const role = document.getElementById('registerRole').value;
        $.ajax({
            url: 'http://localhost:8080/register',  // URL của API đăng nhập
            method: 'POST',
            contentType: 'application/json',
            accept: 'application/json',
            data: JSON.stringify({
                fullName: fullName,
                username: username,
                password: password,
                email: email,
                phoneNumber: phoneNumber,
                address: address,
                role: role
            }),
            success: function(response) {
                console.log(response);
                // Lưu JWT Token vào localStorage
                if (response === null) {
                    alert("ERROR")
                } else {
                    localStorage.setItem("accessToken", response.accessToken);
                    localStorage.setItem("username", username);
                    localStorage.setItem("user_id", response.user_id);
                    // Điều hướng đến trang chính sau khi đăng nhập thành công
                    window.location.href = "/";
                    // Cập nhật topbar
                }
            },
            error: function(xhr, status, error) {
                if (xhr.status === 401) {
                    alert('Failed Login');
                    $('#loginError').show();
                } else {
                    console.log('Lỗi: ', status, error);
                }
            }
        });
    });

    function toggleLoginAndDropdown(showDropdown) {
        const loginModal = document.getElementById('loginModal');
        const dropdown = document.getElementById('myDropItem');

        if (showDropdown) {
            // Hiển thị dropdown, ẩn Đăng nhập
            dropdown.classList.remove('d-none');
            loginModal.classList.add('d-none');
        } else {
            // Hiển thị Đăng nhập, ẩn dropdown
            dropdown.classList.add('d-none');
            loginModal.classList.remove('d-none');
        }
    }

    // Khi người dùng đăng nhập thành công
    function handleLoginSuccess(username) {
        //updateTopbar(username); // Cập nhật nội dung dropdown
        toggleLoginAndDropdown(true); // Hiển thị dropdown
    }

    // Khi người dùng đăng xuất
    function handleLogout() {
        toggleLoginAndDropdown(false); // Hiển thị Đăng nhập
    }

    // Ví dụ: Gọi khi đăng nhập thành công
    document.addEventListener('DOMContentLoaded', () => {
        const isLoggedIn = localStorage.getItem('username'); // Kiểm tra trạng thái đăng nhập
        console.log(isLoggedIn)
        if (isLoggedIn != null) {
            handleLoginSuccess(isLoggedIn); // Nếu đã đăng nhập
        } else {
            handleLogout(); // Nếu chưa đăng nhập
        }
    });


</script>

</body>
</html>
