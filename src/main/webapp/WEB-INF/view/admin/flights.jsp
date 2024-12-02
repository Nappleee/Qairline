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

        <div class="container-fluid flight-container">
            <h1>Flight</h1>
            <div class="mt-4">
                <div class="add-flight">
                    <div></div>
                    <a href="#" class="btn btn-secondary btn-add-flight" data-bs-toggle="modal" data-bs-target="#addFlightModal">
                        Add Flight
                    </a>
                </div>
                <!-- Modal -->
                <div class="modal fade" id="addFlightModal" tabindex="-1" aria-labelledby="addFlightModalLabel" aria-hidden="true" style="display: none">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header d-flex justify-content-center">
                                <h5 class="modal-title" id="addFlightModalLabel">Add Flight</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <!-- Form for Adding Flight -->
                                <%--@elvariable id="addFlightModelAttribute" type=""--%>
                                <form:form id="addFlightForm" method="post" action="/admin/flights" modelAttribute="addFlightModelAttribute">
                                    <!-- Airplane ID -->
                                    <div class="mb-3">
                                        <label for="aircraftModel" class="form-label">Airplane Model</label>
                                        <div class="select-container">
                                            <select class="form-select" class="aircraftModel" id="aircraftModel" name="aircraftModel" required>
                                                <option value="" selected disabled>Select airplane model</option>

                                            </select>
                                        </div>

                                    </div>

                                    <!-- Departure Airport -->
                                    <div class="mb-3">
                                        <label for="departure" class="form-label">Departure</label>
                                        <div class="select-container">
                                            <select class="form-select" id="departure" name="departure" required>
                                                <option value="" selected disabled>Select departure</option>
                                                <option value="HAN">Noi Bai (HAN)</option>
                                                <option value="SGN">Tan Son Nhat (SGN)</option>
                                                <option value="DAD">Da Nang (DAD)</option>
                                            </select>
                                        </div>

                                    </div>

                                    <!-- Arrival Airport -->
                                    <div class="mb-3">
                                        <label for="destination" class="form-label">Destination</label>
                                        <select class="form-select" id="destination" name="destination" required>
                                            <option value="" selected disabled>Select arrival airport</option>
                                            <option value="HAN">Noi Bai (HAN)</option>
                                            <option value="SGN">Tan Son Nhat (SGN)</option>
                                            <option value="DAD">Da Nang (DAD)</option>
                                        </select>
                                    </div>

                                    <!-- Departure Time -->
                                    <div class="mb-3">
                                        <label for="departureTime" class="form-label">Departure Time</label>
                                        <input type="datetime-local" class="form-control" id="departureTime" name="departureTime" required>
                                    </div>


                                    <div class="mb-3">
                                        <label for="ticketPrice" class="form-label">Ticket Price</label>
                                        <input type="number" class="form-control" id="ticketPrice" name="ticketPrice" required>
                                    </div>

                                    <!-- Submit Button -->
                                    <div class="text-center">
                                        <button type="submit" class="btn btn-submit">Add Flight</button>
                                    </div>
                                </form:form>
                            </div>

                        </div>
                    </div>
                </div>

                <!-- Edit Flight Modal -->

                <!-- Edit Flight Modal -->
                <div class="modal fade" id="editFlightModal" tabindex="-1" aria-labelledby="editFlightModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="editFlightModalLabel">Edit Flight</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form id="editFlightForm">
                                    <div class="mb-3">
                                        <label for="editFlightId" class="form-label">Flight ID</label>
                                        <input type="text" id="editFlightId" class="form-control" readonly />
                                    </div>
                                    <div class="mb-3">
                                        <label for="editAircraft" class="form-label text-center">Airplane Model</label>
                                        <div class="select-container">
                                            <select class="form-select" id="editAircraft" name="editAircraft" required>
                                                <option value="" selected disabled>Select airplane model</option>

                                            </select>
                                        </div>

                                    </div>

                                    <!-- Departure Airport -->
                                    <div class="mb-3">
                                        <label for="departure" class="form-label">Departure</label>
                                        <div class="select-container">
                                            <select class="form-select" id="editDeparture" name="departure" required>
                                                <option value="" selected disabled>Select departure</option>
                                                <option value="HAN">Noi Bai (HAN)</option>
                                                <option value="SGN">Tan Son Nhat (SGN)</option>
                                                <option value="DAD">Da Nang (DAD)</option>
                                            </select>
                                        </div>

                                    </div>

                                    <!-- Arrival Airport -->
                                    <div class="mb-3">
                                        <label for="destination" class="form-label">Destination</label>
                                        <select class="form-select" id="editDestination" name="destination" required>
                                            <option value="" selected disabled>Select arrival airport</option>
                                            <option value="HAN">Noi Bai (HAN)</option>
                                            <option value="SGN">Tan Son Nhat (SGN)</option>
                                            <option value="DAD">Da Nang (DAD)</option>
                                        </select>
                                    </div>

                                    <!-- Departure Time -->
                                    <div class="mb-3">
                                        <label for="departureTime" class="form-label">Departure Time</label>
                                        <input type="datetime-local" class="form-control" id="editDepartureTime" name="departureTime" required>
                                    </div>


                                    <div class="mb-3">
                                        <label for="ticketPrice" class="form-label">Ticket Price</label>
                                        <input type="number" class="form-control" id="editTicketPrice" name="ticketPrice" required>
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
                <span>${flightsCount} records found</span>
            </div>
            <div class="mt-1">
                <div class="table-container">
                    <table class="table table-bordered" id="flightsTable">
                        <thead class="table-header">
                        <tr>
                            <th>Flight ID</th>
                            <th>Aircraft Model</th>
                            <th>Departure</th>
                            <th>Destination</th>
                            <th>Departure Time</th>
                            <th>Ticket Price</th>
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
                            Are you sure you want to delete this flight?
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
    function loadFlights(Page, keyword) {
        console.log(Page);
        $.ajax({
            url: '/api/flightsSearch?keyword=' + keyword + '&page='+ Page +'&size=5', // URL của REST API
            method: 'GET',
            dataType: 'json',
            success: function (data) {
                // Lặp qua danh sách flights và thêm vào bảng
                const flights = data.content;
                console.log(flights);

                var rows = '';
                flights.forEach(function (flight) {
                    rows += '<tr>';
                    rows += '<td>' + flight.flightId + '</td>';
                    rows += '<td>' + flight.aircraft + '</td>';
                    rows += '<td>' + flight.departure + '</td>';
                    rows += '<td>' + flight.destination + '</td>';
                    rows += '<td>' + flight.departureTime.toString() + '</td>';
                    rows += '<td>' + flight.ticketPrice + '</td>';
                    rows += '<td class="text-center"><a class="btn-edit" onclick="Edit('+ flight.flightId + ')">Edit</a> / <a class="btn-edit" onclick="confirmDelete('+ flight.flightId + ')">Remove</a></td>';
                    rows += '</tr>';
                });
                // console.log(rows);
                $('#flightsTable tbody').html(rows);

                $('#currentPage').text(`Page: ` + (data.number + 1));
                $('#prevPage').prop('disabled', data.first);
                $('#nextPage').prop('disabled', data.last);
            },
            error: function (xhr, status, error) {
                console.error('Error fetching flights:', status, error);
                console.error('Response:', xhr.responseText);
            }
        });
    };

    let flightIdToDelete = null; // Biến để lưu ID chuyến bay cần xóa

    // Hàm gọi khi người dùng nhấn nút xóa
    function confirmDelete(flightId) {
        flightIdToDelete = flightId; // Lưu ID chuyến bay cần xóa
        $('#deleteConfirmModal').modal('show'); // Hiển thị modal xác nhận
    }

    // Hàm thực hiện xóa khi người dùng chọn "Yes"
    $('#confirmDeleteButton').click(function() {
        console.log(flightIdToDelete);
        if (flightIdToDelete != null) {
            // Gửi yêu cầu xóa chuyến bay bằng AJAX
            $.ajax({
                url: '/api/deleteflight', // Đường dẫn API để xóa
                method: 'POST',
                data: { flightId: flightIdToDelete },
                success: function(response) {
                    $('#deleteConfirmModal').modal('hide');
                    location.reload();
                },
                error: function() {
                    alert('Error occurred while deleting flight.');
                }
            });
        }
    });

    // Hàm mở modal và điền thông tin chuyến bay vào form
    // Hàm mở modal chỉnh sửa chuyến bay
    function Edit(flightId) {
        // Gửi yêu cầu GET để lấy thông tin chuyến bay từ server
        console.log("edit");
        $.ajax({
            url: '/api/flights/' + flightId,  // API lấy thông tin chuyến bay
            method: 'GET',
            dataType: 'json',
            success: function(data) {
                // Điền thông tin vào các trường trong form modal
                $('#editFlightId').val(data.flightId);  // Flight ID
                $('#editAircraft').val(data.aircraft);  // Aircraft
                $('#editDeparture').val(data.departure);  // Departure
                $('#editDestination').val(data.destination);  // Destination
                // Chuyển đổi startDate và endDate
                var departureTime = data.departureTime.replace("<br>", " ");

                departureTime = departureTime.replace(" ", "T").slice(0, 16);

                $('#editDepartureTime').val(departureTime);  // Departure Time (datetime-local)
                $('#editTicketPrice').val(data.ticketPrice);  // Ticket Price

                // Hiển thị modal
                $('#editFlightModal').modal('show');
            },
            error: function(error) {
                console.error('Error fetching flight data:', error);
            }
        });
    }



    $('#editFlightForm').on('submit', function(e) {
        e.preventDefault();

        const flightId = $('#editFlightId').val();
        const departure = $('#editDeparture').val();
        const destination = $('#editDestination').val();
        const departureTime = $('#editDepartureTime').val();
        const ticketPrice = $('#editTicketPrice').val();
        const aircraft = $('#editAircraft').val();  // Lấy giá trị aircraft từ form
        console.log(aircraft);
        // Gửi yêu cầu PUT để cập nhật chuyến bay
        $.ajax({
            url: '/api/flights/' + flightId,
            method: 'PUT',
            data: JSON.stringify({
                flightId: flightId,
                departure: departure,
                destination: destination,
                departureTime: departureTime,
                ticketPrice: ticketPrice,
                aircraftModel: aircraft  // Cập nhật giá trị aircraft
            }),
            contentType: 'application/json',
            dataType: 'json',
            success: function(response) {
                // Cập nhật giao diện sau khi chỉnh sửa thành công
                $('#flightsTable tbody').empty();
                location.reload() // Tải lại dữ liệu sau khi chỉnh sửa
                $('#editFlightModal').modal('hide'); // Đóng modal
            },
            error: function(error) {
                console.error('Error updating flight:', error);
            }
        });
    });


    $(document).ready(function() {
        // Gọi API để lấy danh sách máy bay khi trang tải
        $.ajax({
            url: '/api/getAllAircrafts',
            method: 'GET',
            dataType: 'json',
            success: function(data) {
                console.log("111111111111111");
                // Xóa tất cả các tùy chọn cũ
                $('#aircraftModel').empty();
                $('#editAircraft').empty();
                // Thêm lựa chọn mặc định
                $('#aircraftModel').append('<option value="" selected disabled>Select airplane model</option>');
                $('#editAircraft').append('<option value="" selected disabled>Select airplane model</option>');
                // Duyệt qua danh sách máy bay và thêm mỗi model vào select
                $.each(data, function(index, aircraft) {
                    $('#aircraftModel').append('<option value="' + aircraft.model + '">' + aircraft.model + '</option>');
                    $('#editAircraft').append('<option value="' + aircraft.model + '">' + aircraft.model + '</option>');
                    console.log(2);
                });
            },
            error: function(xhr, status, error) {
                console.error("Error fetching aircraft models: ", error);
            }
        });
    });

    $(document).ready(function() {
        $('#addFlightForm').submit(function(event) {
            event.preventDefault(); // Ngừng việc submit form truyền thống
            console.log(12345);
            var formData = $(this).serialize(); // Lấy dữ liệu từ form
            console.log(formData)
            $.ajax({
                url: '/admin/flights', // Đường dẫn tới controller
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
            currentPage--;
            const keyword = $('#searchInput').val().trim(); // Lấy giá trị input
            loadFlights(currentPage, keyword);
        }
    });

    // Nút Next
    $('#nextPage').click(function () {
        currentPage++;
        console.log(currentPage)
        const keyword = $('#searchInput').val().trim(); // Lấy giá trị input
        loadFlights(currentPage, keyword);
    });

    // Tải trang đầu tiên khi load
    $(document).ready(function () {
        loadFlights(0, "");
    });

    $(document).ready(function () {
        $('#search-icon').click(function() {
            const keyword = $('#searchInput').val().trim(); // Lấy giá trị input
            loadFlights(currentPage, keyword);
        });

        $('#searchInput').keypress(function(event) {
            if (event.which === 13) { // Kiểm tra xem có phải phím Enter (13) không
                event.preventDefault(); // Ngăn chặn form submit
                const keyword = $('#searchInput').val().trim();
                // Gọi API tìm kiếm với từ khóa
                loadFlights(currentPage, keyword);
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
