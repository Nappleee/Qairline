<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <title>aircraft List (JSON Example)</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>aircraft</title>
    <link rel="shortcut icon" type="image/png" href="/images/logos/favicon.png" />
    <link rel="stylesheet" href="/css/admin/styles.min.css" />
    <link rel="stylesheet" href="/css/admin/main.css">
    <link rel="stylesheet" href="/css/admin/aircraft.css">
    <link rel="stylesheet" href="/css/admin/form.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="/libs/simplebar/dist/simplebar.css">
    <link rel="stylesheet" href="/css/admin/icons/tabler-icons/tabler-icons.css">
</head>
<body>
<div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full" data-sidebar-position="fixed" data-header-position="fixed">

    <%@ include file="../share-view/admin_left_sidebar.jsp" %>

    <div class="body-wrapper">
        <header class="app-header">
            <nav class="navbar navbar-expand-lg navbar-light">
                <ul class="navbar-nav">
                    <li class="nav-item d-block d-xl-none">
                        <a class="nav-link sidebartoggler nav-icon-hover" id="headerCollapse" href="javascript:void(0)">
                            <i class="ti ti-menu-2"></i>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-icon-hover" href="javascript:void(0)">
                            <i class="ti ti-bell-ringing"></i>
                            <%--                            <div class="notification bg-primary rounded-circle"></div>--%>
                        </a>
                    </li>
                </ul>
                <div class="navbar-collapse justify-content-end px-0" id="navbarNav">
                    <ul class="navbar-nav flex-row ms-auto align-items-center justify-content-end">
                        <!-- <a href="https://adminmart.com/product/modernize-free-bootstrap-admin-dashboard/" target="_blank" class="btn btn-primary">Download Free</a> -->
                        <li class="nav-item dropdown">
                            <a class="nav-link nav-icon-hover" href="javascript:void(0)" id="drop2" data-bs-toggle="dropdown"
                               aria-expanded="false">
                                <img src="/images/admin/profile/user-1.jpg" alt="" width="35" height="35" class="rounded-circle">
                            </a>
                            <div class="dropdown-menu dropdown-menu-end dropdown-menu-animate-up" aria-labelledby="drop2">
                                <div class="message-body">
                                    <a href="javascript:void(0)" class="d-flex align-items-center gap-2 dropdown-item">
                                        <i class="ti ti-user fs-6"></i>
                                        <p class="mb-0 fs-3">My Profile</p>
                                    </a>
                                    <a href="javascript:void(0)" class="d-flex align-items-center gap-2 dropdown-item">
                                        <i class="ti ti-mail fs-6"></i>
                                        <p class="mb-0 fs-3">My Account</p>
                                    </a>
                                    <a href="javascript:void(0)" class="d-flex align-items-center gap-2 dropdown-item">
                                        <i class="ti ti-list-check fs-6"></i>
                                        <p class="mb-0 fs-3">My Task</p>
                                    </a>
                                    <a href="./authentication-login.html" class="btn btn-outline-primary mx-3 mt-2 d-block">Logout</a>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </nav>
        </header>
        <div class="container-fluid aircraft-container">
            <h1>aircraft</h1>
            <div class="mt-4">
                <div class="add-aircraft">
                    <div></div>
                </div>
            </div>
            <div>
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
                    <span>${aircraftsCount} records found</span>
                </div>
                <div class="row">
                    <div class="mt-1 col-8">
                        <div class="mt-1">
                            <div class="table-container">
                                <table class="table table-bordered" id="aircraftTable">
                                    <thead class="table-header">
                                    <tr>
                                        <th>aircraft ID</th>
                                        <th>Model</th>
                                        <th>Capacity</th>
<%--                                        <th>Action</th>--%>
                                    </tr>
                                    </thead>
                                    <tbody>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="pagination-controls mt-4 d-flex justify-content-center">
                            <button class="page-btn" id="prevPage" disabled>&lt;</button>
                            <span id="currentPage">Page: 1</span><span> / ${pageCount}</span>
                            <button class="page-btn" id="nextPage">&gt;</button>
                        </div>
                    </div>
                    <div class="col-4 mt-1">
                        <div class="form-container mt-1" style="border-radius: 8px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); border: 1px solid #ddd;">
                            <h4 class="d-flex justify-content-center p-3 border-bottom">Add</h4>
                            <%--@elvariable id="addAircraftModelAttribute" type=""--%>
                            <form:form class="" style="padding: 20px;" id="addAircraftForm" method="post" action="/admin/aircrafts" modelAttribute="addAircraftModelAttribute">
                                <div class="mb-4 position-relative">
                                    <label  class="form-label">Model</label>
                                    <input type="text" class="form-control" id="model" name="model" placeholder="Enter Model">
                                    <div class="error-message">Please enter Model.</div>
                                    <div class="error-message aircraftExisted"></div>
                                </div>
                                <div class="mb-4 position-relative">
                                    <label class="form-label">Capacity</label>
                                    <input type="number" class="form-control" id="capacity" name="capacity" placeholder="Enter capacity">
                                    <span class="error-message">Please enter Capacity.</span>
                                </div>
                                <div class="d-flex justify-content-center">
                                    <button type="submit" class="btn btn-primary mb-3">Confirm</button>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>

            </div>


        </div>
    </div>
</div>

<script>
    // Gọi API và hiển thị dữ liệu trong bảng
    let currentPage = 0;
    let keyword = $('#search-input').val();
    function loadAircraft(Page, keyword) {
        console.log(Page);
        $.ajax({
            url: '/api/aircraftsSearch?keyword=' + keyword + '&page='+ Page +'&size=5', // URL của REST API
            method: 'GET',
            dataType: 'json',
            success: function (data) {
                // Lặp qua danh sách aircraft và thêm vào bảng
                const aircraft = data.content;
                console.log(aircraft)

                var rows = '';
                aircraft.forEach(function (aircraft) {
                    rows += '<tr>';
                    rows += '<td>' + aircraft.aircraftId + '</td>';
                    rows += '<td>' + aircraft.model + '</td>';
                    rows += '<td>' + aircraft.capacity + '</td>';
                    //rows += '<td class="text-center"><a class="btn-edit">Edit</a> / <a class="btn-edit" onclick="confirmDelete('+ aircraft.model + ')">Remove</a></td>';
                    rows += '</tr>';
                });
                // console.log(rows);
                $('#aircraftTable tbody').html(rows);

                $('#currentPage').text(`Page: ` + (data.number + 1));
                $('#prevPage').prop('disabled', data.first);
                $('#nextPage').prop('disabled', data.last);
            },
            error: function (error) {
                console.error('Error fetching aircraft:', error);
            }
        });
    };

    $(document).ready(function() {
        $('#addAircraftForm').submit(function(event) {
            event.preventDefault(); // Ngừng việc submit form truyền thống

            var formData = $(this).serialize(); // Lấy dữ liệu từ form

            $.ajax({
                url: '/admin/aircrafts', // Đường dẫn tới controller
                type: 'POST',
                data: formData,
                success: function(response) {
                    // Nếu thêm thành công, bạn có thể làm gì đó, ví dụ thông báo thành công hoặc redirect
                    console.log(response);
                    if (response == "success") {
                        // Nếu thành công, thông báo thành công và có thể reload trang hoặc reset form
                        // alert('Aircraft added successfully!');
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

    // Nút Previous
    $('#prevPage').click(function () {

        if (currentPage > 0) {
            currentPage--;const keyword = $('#searchInput').val().trim();
            loadAircraft(currentPage, "");
        }
    });

    // Nút Next
    $('#nextPage').click(function () {
        currentPage++;
        console.log(currentPage)

        const keyword = $('#searchInput').val().trim();
        loadAircraft(currentPage, keyword);
    });

    // Tải trang đầu tiên khi load
    $(document).ready(function () {
        loadAircraft(0, "");
    });

    $(document).ready(function() {
        $('#addAircraftForm').on('submit', function(event) {
            var valid = true;
            $('.error-message').hide();

            var model = $('#model').val();
            if (model == "") {
                $('#model').siblings('.error-message').show();
                console.log(1);

                valid = false;
            }
            var capacity = $('#capacity').val();
            if (capacity == "") {
                $('#capacity').next('.error-message').show();
                valid = false;
            }

            if (!valid) {
                event.preventDefault();
            }
        });
    });

    $(document).ready(function () {
        $('#search-icon').click(function() {
            const keyword = $('#searchInput').val().trim(); // Lấy giá trị input
            loadAircraft(currentPage, keyword);
        });

        $('#searchInput').keypress(function(event) {
            if (event.which === 13) { // Kiểm tra xem có phải phím Enter (13) không
                event.preventDefault(); // Ngăn chặn form submit
                const keyword = $('#searchInput').val().trim();
                loadAircraft(currentPage, keyword);
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
</html>
