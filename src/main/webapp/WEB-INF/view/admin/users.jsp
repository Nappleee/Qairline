<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer List (JSON Example)</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>Customer</title>
    <link rel="shortcut icon" type="image/png" href="/images/logos/favicon.png" />
    <link rel="stylesheet" href="/css/admin/styles.min.css" />
    <link rel="stylesheet" href="/css/admin/main.css">
    <link rel="stylesheet" href="/css/admin/customer.css">
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
                <div class="add-customer">
                    <div></div>
                    <a href="#" class="btn btn-secondary btn-add-customer" data-bs-toggle="modal" data-bs-target="#addCustomerModal">
                        Add Customer
                    </a>
                </div>
                <!-- Modal -->
                <div class="modal fade" id="addCustomerModal" tabindex="-1" aria-labelledby="addCustomerModalLabel" aria-hidden="true" style="display: none">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header d-flex justify-content-center">
                                <h5 class="modal-title" id="addCustomerModalLabel">Add Customer</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <!-- Form for Adding Customer -->
                                <%--@elvariable id="userRequest" type=""--%>
                                <form:form id="addCustomerForm" method="post" action="/admin/customers" modelAttribute="userRequest">
                                    <div class="mb-3">
                                        <label for="username" class="form-label">Username</label>
                                        <input type="text" class="form-control" id="username" name="username" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="email" class="form-label">Email</label>
                                        <input type="text" class="form-control" id="email" name="email" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="password" class="form-label">Password</label>
                                        <input type="text" class="form-control" id="password" name="password" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="role" class="form-label">Role</label>
                                        <select class="form-select" id="role" name="role" required>
                                            <option value="CUSTOMER" selected>Customer</option>
                                            <option value="ADMIN">Admin</option>
                                        </select>
                                    </div>

                                    <!-- Submit Button -->
                                    <div class="text-center">
                                        <button type="submit" class="btn btn-submit">Add Customer</button>
                                    </div>
                                </form:form>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Edit Customer Modal -->
                <div class="modal fade" id="editCustomerModal" tabindex="-1" aria-labelledby="editCustomerModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="editCustomerModalLabel">Edit Customer</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form id="editCustomerForm">
                                    <div class="mb-3">
                                        <label for="editCustomerId" class="form-label">Customer ID</label>
                                        <input type="text" id="editCustomerId" class="form-control" readonly />
                                    </div>
                                    <div class="mb-3">
                                        <label for="editAircraft" class="form-label text-center">Airplane Model</label>
                                        <div class="select-container">
                                            <select class="form-select" id="editAircraft" name="editAircraft" required>
                                                <option value="" selected disabled>Select airplane model</option>
                                            </select>
                                        </div>
                                    </div>

                                    <button type="submit" class="btn btn-primary">Save Changes</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
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
            headers: {
                'Authorization': 'Bearer ' + localStorage.getItem('accessToken')  // Lấy token từ localStorage
            },
            success: function (data) {
                // Lặp qua danh sách Customers và thêm vào bảng
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
            error: function (error) {
                console.error('Error fetching aircraft:', error);
                window.location.href = '/admin/deny';
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

    $(document).ready(function() {
        $('#addCustomerForm').submit(function(event) {
            event.preventDefault(); // Ngừng việc submit form truyền thống
            var formData = $(this).serialize(); // Lấy dữ liệu từ form
            console.log(formData)
            $.ajax({
                url: '/admin/addcustomer', // Đường dẫn tới controller
                type: 'POST',
                headers: {
                    'Authorization': 'Bearer ' + localStorage.getItem('accessToken')  // Lấy token từ localStorage
                },
                data: formData,
                success: function(response) {
                    // Nếu thêm thành công, bạn có thể làm gì đó, ví dụ thông báo thành công hoặc redirect
                    console.log(response);
                    if (response == "success") {
                        location.reload(); // Hoặc reload trang để hiển thị thay đổi

                    } else {
                        // Nếu có lỗi (chẳng hạn, model đã tồn tại), hiển thị thông báo lỗi
                        $('.error-message').text(response); // Hiển thị thông báo lỗi vào div error-message
                        $('.aircraftExisted').show();
                        event.preventDefault();
                    }
                    //location.reload(); // Hoặc reload trang để hiển thị thay đổi
                },
            });
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