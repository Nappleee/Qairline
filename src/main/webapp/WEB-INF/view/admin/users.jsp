<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <title>Flight List (JSON Example)</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>Flight</title>
    <link rel="shortcut icon" type="image/png" href="/images/logos/favicon.png" />
    <link rel="stylesheet" href="/css/admin/styles.min.css" />
    <link rel="stylesheet" href="/css/admin/main.css">
    <link rel="stylesheet" href="/css/admin/flight.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="/libs/simplebar/dist/simplebar.css">
    <link rel="stylesheet" href="/css/admin/icons/tabler-icons/tabler-icons.css">

</head>
<body>
<div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full" data-sidebar-position="fixed" data-header-position="fixed">

    <%@ include file="../share-view/admin_left_sidebar.jsp" %>


    <div class="body-wrapper">
        <%@ include file="../share-view/admin_header.jsp" %>

        <div class="container-fluid user-container">
            <h1>Customer</h1>
            <div class="mt-4">
                <div class="toolbar">
                    <!-- Search Box -->
                    <div class="search-box">
                        <input type="text" id="searchInput" placeholder="Search by keyword">
                        <i id="search-icon" class="bi bi-search search-icon"></i>
                    </div>
                </div>
            </div>
            <div class="mt-4">
                <span>${usersCount} records found</span>
            </div>
            <div class="mt-1">
                <div class="table-container">
                    <table class="table table-bordered" id="usersTable">
                        <thead class="table-header">
                        <tr>
                            <th>User ID</th>
                            <th>Full Name</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Phone Number</th>
                            <th>Address</th>
                            <th>Role</th>
                            <th>Create at</th>
                        </tr>
                        </thead>
                        <tbody>

                        <!-- Add more rows as needed -->
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="pagination-controls mt-1 d-flex justify-content-center">

                <button class="page-btn" id="prevPage" disabled>&lt;</button>
                <span id="currentPage">Page: 1</span><span> / ${pageCount}</span>
                <button class="page-btn" id="nextPage">&gt;</button>
            </div>
        </div>
    </div>
</div>

<script>
    let currentPage = 0;
    let keyword = $('#search-input').val();
    function loadUsers(Page, keyword) {
        console.log(Page);
        $.ajax({
            url: '/api/usersSearch?keyword=' + keyword + '&page='+ Page +'&size=5', // URL của REST API
            method: 'GET',
            dataType: 'json',
            success: function (data) {
                // Lặp qua danh sách flights và thêm vào bảng
                const users = data.content;
                console.log('/api/users?keyword=' + keyword + '&page='+ Page +'&size=5');

                var rows = '';
                users.forEach(function (user) {
                    rows += '<tr>';
                    rows += '<td>' + user.userId + '</td>';
                    rows += '<td>' + user.fullName + '</td>';
                    rows += '<td>' + user.username + '</td>';
                    rows += '<td>' + user.email + '</td>';
                    rows += '<td>' + user.phoneNumber + '</td>';
                    rows += '<td>' + user.address + '</td>';
                    rows += '<td>' + user.role + '</td>';
                    rows += '<td>' + user.createdAt + '</td>';
                    //rows += '<td class="text-center"><a class="btn-edit" onclick="Edit('+ flight.flightId + ')">Edit</a> / <a class="btn-edit" onclick="confirmDelete('+ flight.flightId + ')">Remove</a></td>';
                    rows += '</tr>';
                });
                // console.log(rows);
                $('#usersTable tbody').html(rows);

                $('#currentPage').text(`Page: ` + (data.number + 1));
                $('#prevPage').prop('disabled', data.first);
                $('#nextPage').prop('disabled', data.last);
            },
            error: function (xhr, status, error) {
                console.error('Error fetching users:', status, error);
                console.error('Response:', xhr.responseText);
            }
        });
    };

    $('#prevPage').click(function () {

        if (currentPage > 0) {
            currentPage--;
            const keyword = $('#searchInput').val().trim(); // Lấy giá trị input
            loadUsers(currentPage, keyword);
        }
    });

    // Nút Next
    $('#nextPage').click(function () {
        currentPage++;
        console.log(currentPage)

        const keyword = $('#searchInput').val().trim(); // Lấy giá trị input
        loadUsers(currentPage, keyword);
    });

    // Tải trang đầu tiên khi load
    $(document).ready(function () {
        loadUsers(0, "");
    });

    $(document).ready(function () {
        $('#search-icon').click(function() {
            const keyword = $('#searchInput').val().trim(); // Lấy giá trị input
            loadUsers(currentPage, keyword);
        });

        $('#searchInput').keypress(function(event) {
            if (event.which === 13) { // Kiểm tra xem có phải phím Enter (13) không
                event.preventDefault(); // Ngăn chặn form submit
                const keyword = $('#searchInput').val().trim();
                loadUsers(currentPage, keyword);
            }
        });
    });

</script>

<script src="/libs/jquery/dist/jquery.min.js"></script>
<script src="/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
<script src="/js/sidebarmenu.js"></script>
<script src="/js/app.min.js"></script>
<script src="/libs/apexcharts/dist/apexcharts.min.js"></script>
<script src="/libs/simplebar/dist/simplebar.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>