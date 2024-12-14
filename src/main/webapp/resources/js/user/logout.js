function LogOut() {
    // Xóa tất cả dữ liệu trong localStorage
    localStorage.clear();

    // Chuyển hướng người dùng về trang đăng nhập hoặc trang chủ
    window.location.href = '/'; // Thay đổi đường dẫn này tùy vào ứng dụng của bạn
}