<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ticket List (JSON Example)</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>Ticket</title>
    <link rel="shortcut icon" type="image/png" href="/images/logos/favicon.png" />
    <link rel="stylesheet" href="/css/admin/styles.min.css" />
    <link rel="stylesheet" href="/css/admin/main.css">
    <link rel="stylesheet" href="/css/admin/ticket.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="/libs/simplebar/dist/simplebar.css">
    <link rel="stylesheet" href="/css/admin/icons/tabler-icons/tabler-icons.css">
</head>
<body>
<div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full" data-sidebar-position="fixed" data-header-position="fixed">

    <%@ include file="../share-view/admin_left_sidebar.jsp" %>

    <div class="body-wrapper">
        <%@ include file="../share-view/admin_header.jsp" %>

        <div class="container-fluid ticket-container">
            <h1>Ticket</h1>
            <div class="mt-4">
                <div class="add-ticket">
                    <div></div>
                    <a href="#" class="btn btn-secondary btn-add-ticket" data-bs-toggle="modal" data-bs-target="#addTicketModal">
                        Add Ticket
                    </a>
                </div>
                <!-- Modal -->
                <div class="modal fade" id="addTicketModal" tabindex="-1" aria-labelledby="addTicketModalLabel" aria-hidden="true" style="display: none">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header d-flex justify-content-center">
                                <h5 class="modal-title" id="addTicketModalLabel">Add Ticket</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <!-- Form for Adding Ticket -->
                                <%--@elvariable id="addTicketModelAttribute" type=""--%>
                                <form:form id="addTicketForm" method="post" action="/admin/tickets" modelAttribute="addTicketModelAttribute">
                                    <!-- Airplane ID -->
                                    <div class="mb-3">
                                        <label for="flightId" class="form-label">Flight Id</label>
                                        <div class="select-container">
                                            <select class="form-select" class="flightId" id="flightId" name="flightId" required>
                                                <option value="" selected disabled>Select Flight Id</option>

                                            </select>
                                        </div>

                                    </div>

                                    <!-- Departure Airport -->
                                    <div class="mb-3">
                                        <label for="userName" class="form-label">UserName</label>
                                        <div class="select-container">
                                            <select class="form-select" class="userName" id="userName" name="userName">
                                                <option value="" selected disabled>Select UserName</option>

                                            </select>
                                        </div>

                                    </div>

                                    <div class="mb-3">
                                        <label for="seatNumber" class="form-label">Seat Number</label>
                                        <input type="text" class="form-control" id="seatNumber" name="seatNumber" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="promotionId" class="form-label">promotionId</label>
                                        <div class="select-container">
                                            <select class="form-select" class="promotionId" id="promotionId" name="promotionId">
                                                <option value="" selected disabled>Select promotionId</option>

                                            </select>
                                        </div>
                                    </div>

                                    <!-- Submit Button -->
                                    <div class="text-center">
                                        <button type="submit" class="btn btn-submit">Add Ticket</button>
                                    </div>
                                </form:form>
                            </div>

                        </div>
                    </div>
                </div>

                <!-- Edit Ticket Modal -->

                <!-- Edit Ticket Modal -->
                <div class="modal fade" id="editTicketModal" tabindex="-1" aria-labelledby="editTicketModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="editTicketModalLabel">Edit Ticket</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form id="editTicketForm">
                                    <div class="mb-3">
                                        <label for="editTicketId" class="form-label">Ticket ID</label>
                                        <input type="text" id="editTicketId" class="form-control" readonly />
                                    </div>

                                    <!-- Airplane ID -->
                                    <div class="mb-3">
                                        <label for="editFlightId" class="form-label">Flight Id</label>
                                        <div class="select-container">
                                            <select class="form-select" class="editFlightId" id="editFlightId" name="flightId">
                                                <option value="" selected disabled>Select Flight Id</option>

                                            </select>
                                        </div>

                                    </div>

                                    <!-- Departure Airport -->
                                    <div class="mb-3">
                                        <label for="editUserName" class="form-label">UserName</label>
                                        <div class="select-container">
                                            <select class="form-select" class="editUserName" id="editUserName" name="editUserName">
                                                <option value="" selected disabled>Select UserName</option>

                                            </select>
                                        </div>

                                    </div>

                                    <div class="mb-3">
                                        <label for="editSeatNumber" class="form-label">Seat Number</label>
                                        <input type="text" class="form-control" id="editSeatNumber" name="editSeatNumber" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="editPromotionId" class="form-label">promotionId</label>
                                        <div class="select-container">
                                            <select class="form-select" class="editPromotionId" id="editPromotionId" name="editPromotionId">
                                                <option value="" selected disabled>Select promotionId</option>

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
<%--                    <div class="search-box">--%>
<%--                        <input type="text" id="searchInput" placeholder="Search by keyword">--%>
<%--                        <i id="search-icon" class="bi bi-search search-icon"></i>--%>
<%--                    </div>--%>
                    <div class="d-flex align-items-center">
                        <select id="searchSelect" class="form-control mr-3" style="margin-right: 3px">
                            <option value="all">Get All</option>
                            <option value="available">Remaining Tickets</option>
                            <option value="userTickets">Get By User</option>
                        </select>
                        <select id="userSelect" class="form-control" style="display: none;">
                            <!-- Các user sẽ được thêm vào đây -->
                        </select>
                    </div>
                </div>
            </div>
            <div class="mt-4">
                <span>${ticketsCount} records found</span>
            </div>
            <div class="mt-1">
                <div class="table-container">
                    <table class="table table-bordered" id="ticketsTable">
                        <thead class="table-header">
                        <tr>
                            <th>Ticket Id</th>
                            <th>Flight Id</th>
                            <th>User Name</th>
                            <th>Seat Number</th>
                            <th>Status</th>
                            <th>Promotion Id</th>
                            <th>Final Price</th>
                            <th>Action</th>
                        </tr>
                        </thead>
                        <tbody>

                        <!-- Add more rows as needed -->
                        </tbody>
                    </table>
                </div>
            </div>
            <!-- Modal xác nhận xóa -->
            <div class="modal" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteConfirmModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="deleteConfirmModalLabel">Confirm Deletion</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            Are you sure you want to delete this ticket?
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="button" class="btn btn-danger" id="confirmDeleteButton">Yes</button>
                        </div>
                    </div>
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
    // Gọi API và hiển thị dữ liệu trong bảng
    let currentPage = 0;
    let keyword = $('#search-input').val();
    function loadTickets(Page, keyword) {
        console.log(Page);
        $.ajax({
            url: '/api/ticketsSearch?keyword=' + keyword + '&page='+ Page +'&size=5', // URL của REST API
            method: 'GET',
            dataType: 'json',
            headers: {
                'Authorization': 'Bearer ' + localStorage.getItem('accessToken')  // Lấy token từ localStorage
            },
            success: function (data) {
                const tickets = data.content;
                console.log(tickets);

                var rows = '';
                tickets.forEach(function (ticket) {
                    var userName = null;
                    if (ticket.userName != null) {
                        userName = ticket.userName;
                    }

                    rows += '<tr>';
                    rows += '<td>' + ticket.ticketId + '</td>';
                    rows += '<td>' + ticket.flightId + '</td>';
                    rows += '<td>' + userName + '</td>';
                    rows += '<td>' + ticket.seatNumber + '</td>';
                    rows += '<td>' + ticket.status + '</td>';
                    rows += '<td>' + ticket.promotionId + '</td>';
                    rows += '<td>' + ticket.finalPrice + '</td>';
                    rows += '<td class="text-center"><a class="btn-edit" onclick="Edit('+ ticket.ticketId + ')">Edit</a> / <a class="btn-edit" onclick="confirmDelete('+ ticket.ticketId + ')">Remove</a></td>';
                    rows += '</tr>';
                });
                // console.log(rows);
                $('#ticketsTable tbody').html(rows);

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

    let ticketIdToDelete = null;

    function confirmDelete(ticketId) {
        ticketIdToDelete = ticketId;
        $('#deleteConfirmModal').modal('show');
    }

    $('#confirmDeleteButton').click(function() {
        console.log(ticketIdToDelete);
        if (ticketIdToDelete != null) {
            $.ajax({
                url: '/api/deleteticket',
                method: 'POST',
                headers: {
                    'Authorization': 'Bearer ' + localStorage.getItem('accessToken')  // Lấy token từ localStorage
                },
                data: { ticketId: ticketIdToDelete },
                success: function(response) {
                    $('#deleteConfirmModal').modal('hide');
                    location.reload();
                },
                error: function() {
                    alert('Error occurred while deleting ticket.');
                }
            });
        }
    });

    function Edit(ticketId) {
        console.log("edit");
        $.ajax({
            url: '/api/tickets/' + ticketId,  // API lấy thông tin chuyến bay
            method: 'GET',
            dataType: 'json',
            headers: {
                'Authorization': 'Bearer ' + localStorage.getItem('accessToken')  // Lấy token từ localStorage
            },
            success: function(data) {
                // Điền thông tin vào các trường trong form modal
                $('#editTicketId').val(data.ticketId);  // Ticket ID
                $('#editFlightId').val(data.flightId);  // Aircraft
                $('#editUserName').val(data.userName);  // Departure
                $('#editSeatNumber').val(data.seatNumber);  // Destination
                $('#editPromotionId').val(data.promotionId);  // Destination
                // Hiển thị modal
                $('#editTicketModal').modal('show');
            },
            error: function(error) {
                console.error('Error fetching ticket data:', error);
            }
        });
    }

    $('#editTicketForm').on('submit', function(e) {
        e.preventDefault();

        const ticketId = $('#editTicketId').val();
        const flightId = $('#editFlightId').val();
        const userName = $('#editUserName').val();
        const seatNumber = $('#editSeatNumber').val();
        const promotionId = $('#editPromotionId').val();
        // Gửi yêu cầu PUT để cập nhật chuyến bay
        $.ajax({
            url: '/api/tickets/' + ticketId,
            method: 'PUT',
            headers: {
                'Authorization': 'Bearer ' + localStorage.getItem('accessToken')  // Lấy token từ localStorage
            },
            data: JSON.stringify({
                ticketId: ticketId,
                flightId: flightId,
                userName: userName,
                seatNumber: seatNumber,
                promotionId: promotionId
            }),
            contentType: 'application/json',
            dataType: 'json',
            success: function(response) {
                // Cập nhật giao diện sau khi chỉnh sửa thành công
                $('#ticketsTable tbody').empty();
                location.reload() // Tải lại dữ liệu sau khi chỉnh sửa
                $('#editTicketModal').modal('hide'); // Đóng modal
            },
            error: function(error) {
                console.error('Error updating ticket:', error);
            }
        });
    });


    $(document).ready(function() {
        // Gọi API để lấy danh sách máy bay khi trang tải
        $.ajax({
            url: '/api/getAllFlights',
            method: 'GET',
            dataType: 'json',
            headers: {
                'Authorization': 'Bearer ' + localStorage.getItem('accessToken')  // Lấy token từ localStorage
            },
            success: function(data) {
                console.log("111111111111111");
                // Xóa tất cả các tùy chọn cũ
                $('#flightId').empty();
                $('#editFlightId').empty();
                // Thêm lựa chọn mặc định
                $('#flightId').append('<option value="" selected disabled>Select flight id</option>');
                $('#editFlightId').append('<option value="" selected disabled>Select flight id</option>');
                // Duyệt qua danh sách máy bay và thêm mỗi model vào select
                $.each(data, function(index, flight) {
                    $('#flightId').append('<option value="' + flight.flightId + '">' + flight.flightId + '</option>');
                    $('#editFlightId').append('<option value="' + flight.flightId + '">' + flight.flightId + '</option>');
                    console.log(2);
                });
            },
            error: function(xhr, status, error) {
                console.error("Error fetching aircraft models: ", error);
            }
        });

        $.ajax({
            url: '/api/getAllUsers',
            method: 'GET',
            dataType: 'json',
            headers: {
                'Authorization': 'Bearer ' + localStorage.getItem('accessToken')  // Lấy token từ localStorage
            },
            success: function(data) {
                console.log("2");
                // Xóa tất cả các tùy chọn cũ
                $('#userName').empty();
                $('#editUserName').empty();
                // Thêm lựa chọn mặc định
                $('#userName').append('<option value="" selected disabled>Select Username</option>');
                $('#editUserName').append('<option value="" selected disabled>Select Username</option>');
                $('#userSelect').append('<option value="" selected disabled>Select Username</option>');

                // Duyệt qua danh sách máy bay và thêm mỗi model vào select
                $.each(data, function(index, user) {
                    $('#userName').append('<option value="' + user.username + '">' + user.username + '</option>');
                    $('#editUserName').append('<option value="' + user.username + '">' + user.username + '</option>');
                    $('#userSelect').append('<option value="' + user.username + '">' + user.username + '</option>');
                    console.log(2);
                });
            },
            error: function(xhr, status, error) {
                console.error("Error fetching user models: ", error);
            }
        });


        $.ajax({
            url: '/api/getAllPromotions',
            method: 'GET',
            dataType: 'json',
            headers: {
                'Authorization': 'Bearer ' + localStorage.getItem('accessToken')  // Lấy token từ localStorage
            },
            success: function(data) {
                console.log("3");
                // Xóa tất cả các tùy chọn cũ
                $('#promotionId').empty();
                $('#editPromotionId').empty();
                // Thêm lựa chọn mặc định
                $('#promotionId').append('<option value="" selected disabled>Select promotionId</option>');
                $('#editPromotionId').append('<option value="" selected disabled>Select promotionId</option>');
                // Duyệt qua danh sách máy bay và thêm mỗi model vào select
                $.each(data, function(index, promotion) {
                    $('#promotionId').append('<option value="' + promotion.promotionId + '">' + promotion.promotionId + '</option>');
                    $('#editPromotionId').append('<option value="' + promotion.promotionId + '">' + promotion.promotionId + '</option>');
                    console.log(2);
                });
            },
            error: function(xhr, status, error) {
                console.error("Error fetching aircraft models: ", error);
            }
        });
    });

    $(document).ready(function() {
        $('#addTicketForm').submit(function(event) {
            event.preventDefault(); // Ngừng việc submit form truyền thống
            console.log(12345);
            var formData = $(this).serialize(); // Lấy dữ liệu từ form
            console.log(formData)
            $.ajax({
                url: '/admin/addtickets', // Đường dẫn tới controller
                type: 'POST',
                data: formData,
                headers: {
                    'Authorization': 'Bearer ' + localStorage.getItem('accessToken')  // Lấy token từ localStorage
                },
                success: function(response) {
                    console.log(formData);
                    if (response == "success") {
                        location.reload();

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
            currentPage--;
            //const keyword = $('#searchInput').val().trim(); // Lấy giá trị input
            loadTickets(currentPage, "");
        }
    });

    // Nút Next
    $('#nextPage').click(function () {
        currentPage++;
        console.log(currentPage)
        //const keyword = $('#searchInput').val().trim(); // Lấy giá trị input
        loadTickets(currentPage, "");
    });

    // Tải trang đầu tiên khi load
    $(document).ready(function () {
        loadTickets(0, "");
    });

    // $(document).ready(function () {
    //     $('#search-icon').click(function() {
    //         const keyword = $('#searchInput').val().trim(); // Lấy giá trị input
    //         loadTickets(currentPage, keyword);
    //     });
    //
    //     $('#searchInput').keypress(function(event) {
    //         if (event.which === 13) { // Kiểm tra xem có phải phím Enter (13) không
    //             event.preventDefault(); // Ngăn chặn form submit
    //             const keyword = $('#searchInput').val().trim();
    //             // Gọi API tìm kiếm với từ khóa
    //             loadTickets(currentPage, keyword);
    //         }
    //     });
    // });

    $(document).ready(function (){
        $('#searchSelect').change(function() {
            const selectedOption = $(this).val();

            if (selectedOption === 'all') {
                $('#userSelect').hide();
                loadTickets(currentPage, "")
                // Gửi yêu cầu lấy tất cả vé
                console.log('all');
            } else if (selectedOption === 'available') {
                $('#userSelect').hide();
                $.ajax({
                    url: '/api/ticketsByUserisNull?' + '&page='+ currentPage +'&size=5', // URL của REST API
                    method: 'GET',
                    dataType: 'json',
                    headers: {
                        'Authorization': 'Bearer ' + localStorage.getItem('accessToken')  // Lấy token từ localStorage
                    },
                    success: function (data) {
                        const tickets = data.content;
                        console.log(tickets);

                        var rows = '';
                        tickets.forEach(function (ticket) {
                            var userName = null;
                            if (ticket.userName != null) {
                                userName = ticket.userName;
                            }

                            rows += '<tr>';
                            rows += '<td>' + ticket.ticketId + '</td>';
                            rows += '<td>' + ticket.flightId + '</td>';
                            rows += '<td>' + userName + '</td>';
                            rows += '<td>' + ticket.seatNumber + '</td>';
                            rows += '<td>' + ticket.status + '</td>';
                            rows += '<td>' + ticket.promotionId + '</td>';
                            rows += '<td>' + ticket.finalPrice + '</td>';
                            rows += '<td class="text-center"><a class="btn-edit" onclick="Edit('+ ticket.ticketId + ')">Edit</a> / <a class="btn-edit" onclick="confirmDelete('+ ticket.ticketId + ')">Remove</a></td>';
                            rows += '</tr>';
                        });
                        // console.log(rows);
                        $('#ticketsTable tbody').html(rows);

                        $('#currentPage').text(`Page: ` + (data.number + 1));
                        $('#prevPage').prop('disabled', data.first);
                        $('#nextPage').prop('disabled', data.last);
                    },
                    error: function (xhr, status, error) {
                        console.error('Error fetching Tickets:', status, error);
                        console.error('Response:', xhr.responseText);
                    }
                });
                // Gửi yêu cầu lấy vé chưa mua
                console.log('available');
            } else if (selectedOption === 'userTickets') {
                $('#userSelect').show();
                $('#userSelect').change(function () {
                    console.log($('#userSelect').val());
                    $.ajax({
                        url: '/api/ticketsByUserName?username=' + $('#userSelect').val() + '&page='+ currentPage +'&size=5', // URL của REST API
                        method: 'GET',
                        dataType: 'json',
                        headers: {
                            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')  // Lấy token từ localStorage
                        },
                        success: function (data) {
                            const tickets = data.content;
                            console.log('/api/ticketsByUserName?username=' + $('userSelect').val() + '&page='+ currentPage +'&size=5');

                            var rows = '';
                            tickets.forEach(function (ticket) {
                                var userName = null;
                                if (ticket.userName != null) {
                                    userName = ticket.userName;
                                }

                                rows += '<tr>';
                                rows += '<td>' + ticket.ticketId + '</td>';
                                rows += '<td>' + ticket.flightId + '</td>';
                                rows += '<td>' + userName + '</td>';
                                rows += '<td>' + ticket.seatNumber + '</td>';
                                rows += '<td>' + ticket.status + '</td>';
                                rows += '<td>' + ticket.promotionId + '</td>';
                                rows += '<td>' + ticket.finalPrice + '</td>';
                                rows += '<td class="text-center"><a class="btn-edit" onclick="Edit('+ ticket.ticketId + ')">Edit</a> / <a class="btn-edit" onclick="confirmDelete('+ ticket.ticketId + ')">Remove</a></td>';
                                rows += '</tr>';
                            });
                            // console.log(rows);
                            $('#ticketsTable tbody').html(rows);

                            $('#currentPage').text(`Page: ` + (data.number + 1));
                            $('#prevPage').prop('disabled', data.first);
                            $('#nextPage').prop('disabled', data.last);
                        },
                        error: function (xhr, status, error) {
                            console.error('Error fetching Tickets:', status, error);
                            console.error('Response:', xhr.responseText);
                        }
                    });
                })

                // Lấy thông tin user và gửi yêu cầu lấy vé đã mua
                //const userId = getUserId(); // Bạn có thể lấy userId từ session hoặc token
                console.log(userId);
            }
        });
    })
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
