<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <title>Promotion List (JSON Example)</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>Promotion</title>
    <link rel="shortcut icon" type="image/png" href="/images/logos/favicon.png" />
    <link rel="stylesheet" href="/css/admin/styles.min.css" />
    <link rel="stylesheet" href="/css/admin/main.css">
    <link rel="stylesheet" href="/css/admin/promotion.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="/libs/simplebar/dist/simplebar.css">
    <link rel="stylesheet" href="/css/admin/icons/tabler-icons/tabler-icons.css">

</head>
<body>
<div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full" data-sidebar-position="fixed" data-header-position="fixed">

    <%@ include file="../share-view/admin_left_sidebar.jsp" %>


    <div class="body-wrapper">
        <%@ include file="../share-view/admin_header.jsp" %>

        <div class="container-fluid promotion-container">
            <h1>Promotion</h1>
            <div class="mt-4">
                <div class="add-promotion">
                    <div></div>
                    <a href="#" class="btn btn-secondary btn-add-promotion" data-bs-toggle="modal" data-bs-target="#addPromotionModal">
                        Add Promotion
                    </a>
                </div>
                <!-- Modal -->
                <div class="modal fade" id="addPromotionModal" tabindex="-1" aria-labelledby="addPromotionModalLabel" aria-hidden="true" style="display: none">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header d-flex justify-content-center">
                                <h5 class="modal-title" id="addPromotionModalLabel">Add Promotion</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <!-- Form for Adding Promotion -->
                                <%--@elvariable id="addPromotionModelAttribute" type=""--%>
                                <form:form id="addPromotionForm" method="post" action="/admin/promotions" modelAttribute="addPromotionModelAttribute">
                                    <div class="mb-3">
                                        <label for="description" class="form-label">Description</label>
                                        <input type="text" class="form-control" id="description" name="description" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="discountPercent" class="form-label">Discount Percent</label>
                                        <input type="number" class="form-control" id="discountPercent" name="discountPercent" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="startDate" class="form-label">Start Date</label>
                                        <input type="datetime-local" class="form-control" id="startDate" name="startDate" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="endDate" class="form-label">End Date</label>
                                        <input type="datetime-local" class="form-control" id="endDate" name="endDate" required>
                                    </div>

                                    <!-- Submit Button -->
                                    <div class="text-center">
                                        <button type="submit" class="btn btn-submit">Add Promotion</button>
                                    </div>
                                </form:form>
                            </div>

                        </div>
                    </div>
                </div>

                <!-- Edit Promotion Modal -->

                <!-- Edit Promotion Modal -->
                <div class="modal fade" id="editPromotionModal" tabindex="-1" aria-labelledby="editPromotionModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="editPromotionModalLabel">Edit Promotion</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form id="editPromotionForm">
                                    <div class="mb-3">
                                        <label for="editPromotionId" class="form-label">Promotion ID</label>
                                        <input type="text" id="editPromotionId" class="form-control" readonly />
                                    </div>
                                    <div class="mb-3">
                                        <label for="editDescription" class="form-label">Description</label>
                                        <input type="text" class="form-control" id="editDescription" name="editDescription" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="editDiscountPercent" class="form-label">Discount Percent</label>
                                        <input type="number" class="form-control" id="editDiscountPercent" name="editDiscountPercent" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="editStartDate" class="form-label">Start Date</label>
                                        <input type="datetime-local" class="form-control" id="editStartDate" name="editStartDate" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="editEndDate" class="form-label">End Date</label>
                                        <input type="datetime-local" class="form-control" id="editEndDate" name="editEndDate" required>
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
                <span>${promotionsCount} records found</span>
            </div>
            <div class="mt-1">
                <div class="table-container">
                    <table class="table table-bordered" id="promotionsTable">
                        <thead class="table-header">
                        <tr>
                            <th>Promotion ID</th>
                            <th>Descripton</th>
                            <th>Discount percent</th>
                            <th>Start date</th>
                            <th>End Date</th>
                            <th>Action</th>
                        </tr>
                        </thead>
                        <tbody>

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
                            Are you sure you want to delete this promotion?
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
    let currentPage = 0;
    let keyword = $('#search-input').val();
    function loadPromotions(Page, keyword) {
        console.log(Page);
        $.ajax({
            url: '/api/promotionsSearch?keyword=' + keyword + '&page='+ Page +'&size=5', // URL của REST API
            method: 'GET',
            dataType: 'json',
            success: function (data) {
                // Lặp qua danh sách promotions và thêm vào bảng
                const promotions = data.content;
                console.log(promotions);

                var rows = '';
                promotions.forEach(function (promotion) {
                    rows += '<tr>';
                    rows += '<td>' + promotion.promotionId + '</td>';
                    rows += '<td>' + promotion.description + '</td>';
                    rows += '<td>' + promotion.discountPercent + '</td>';
                    rows += '<td>' + promotion.startDate.toString() + '</td>';
                    rows += '<td>' + promotion.endDate.toString() + '</td>';
                    rows += '<td class="text-center"><a class="btn-edit" onclick="Edit('+ promotion.promotionId + ')">Edit</a> / <a class="btn-edit" onclick="confirmDelete('+ promotion.promotionId + ')">Remove</a></td>';
                    rows += '</tr>';
                });
                // console.log(rows);
                $('#promotionsTable tbody').html(rows);

                $('#currentPage').text(`Page: ` + (data.number + 1));
                $('#prevPage').prop('disabled', data.first);
                $('#nextPage').prop('disabled', data.last);
            },
            error: function (xhr, status, error) {
                console.error('Error fetching promotions:', status, error);
                console.error('Response:', xhr.responseText);
            }
        });
    };

    let promotionIdToDelete = null;

    function confirmDelete(promotionId) {
        promotionIdToDelete = promotionId;
        $('#deleteConfirmModal').modal('show');
    }

    $('#confirmDeleteButton').click(function() {
        console.log(promotionIdToDelete);
        if (promotionIdToDelete != null) {
            $.ajax({
                url: '/api/deletepromotion', // Đường dẫn API để xóa
                method: 'POST',
                data: { promotionId: promotionIdToDelete },
                success: function(response) {
                    $('#deleteConfirmModal').modal('hide');
                    location.reload();
                },
                error: function() {
                    alert('Error occurred while deleting promotion.');
                }
            });
        }
    });

    function Edit(promotionId) {
        // Gửi yêu cầu GET để lấy thông tin chuyến bay từ server
        console.log("edit");
        $.ajax({
            url: '/api/promotions/' + promotionId,  // API lấy thông tin chuyến bay
            method: 'GET',
            dataType: 'json',
            success: function(data) {
                // Điền thông tin vào các trường trong form modal
                $('#editPromotionId').val(data.promotionId);
                console.log(data.description);
                $('#editDescription').val(data.description);
                $('#editDiscountPercent').val(data.discountPercent);

                // Chuyển đổi startDate và endDate
                var startDate = data.startDate.replace("<br>", " ");  // Thay <br> bằng khoảng trắng
                var endDate = data.endDate.replace("<br>", " ");  // Thay <br> bằng khoảng trắng

                // Sau đó, chuyển chuỗi thành định dạng phù hợp cho datetime-local
                startDate = startDate.replace(" ", "T").slice(0, 16);  // Chuyển thành 'yyyy-MM-ddTHH:mm'
                endDate = endDate.replace(" ", "T").slice(0, 16);  // Chuyển thành 'yyyy-MM-ddTHH:mm'

                // Điền vào các input datetime-local
                $('#editStartDate').val(startDate);  // Gắn vào input startDate
                $('#editEndDate').val(endDate);  // Gắn vào input endDate
                // $('#editStartDate').val(data.startDate);
                // $('#editEndDate').val(data.endDate);

                // Hiển thị modal
                $('#editPromotionModal').modal('show');
            },
            error: function(error) {
                console.error('Error fetching promotion data:', error);
            }
        });
    }



    $('#editPromotionForm').on('submit', function(e) {
        e.preventDefault();

        const promotionId = $('#editPromotionId').val();
        const description = $('#editDescription').val();
        const discountPercent = $('#editDiscountPercent').val();
        const startDate = $('#editStartDate').val();
        const endDate = $('#editEndDate').val();
        // Gửi yêu cầu PUT để cập nhật chuyến bay
        $.ajax({
            url: '/api/promotions/' + promotionId,
            method: 'PUT',
            data: JSON.stringify({
                promotionId: promotionId,
                description: description,
                discountPercent: discountPercent,
                startDate: startDate,
                endDate: endDate
            }),
            contentType: 'application/json',
            dataType: 'json',
            success: function(response) {
                // Cập nhật giao diện sau khi chỉnh sửa thành công
                $('#promotionsTable tbody').empty();
                location.reload() // Tải lại dữ liệu sau khi chỉnh sửa
                $('#editPromotionModal').modal('hide'); // Đóng modal
            },
            error: function(error) {
                console.error('Error updating promotion:', error);
            }
        });
    });


    $(document).ready(function() {
        $('#addPromotionForm').submit(function(event) {
            event.preventDefault();
            console.log(12345);
            var formData = $(this).serialize();
            console.log(formData)
            $.ajax({
                url: '/admin/promotions',
                type: 'POST',
                data: formData,
                success: function(response) {
                    console.log(response);
                    if (response == "success") {
                        location.reload();

                    } else {
                        $('.error-message').text(response);
                        $('.aircraftExisted').show();
                        event.preventDefault();
                    }
                },
            });
        });
    });

    // Nút Previous
    $('#prevPage').click(function () {

        if (currentPage > 0) {
            currentPage--;
            const keyword = $('#searchInput').val().trim(); // Lấy giá trị input
            loadPromotions(currentPage, keyword);
        }
    });

    // Nút Next
    $('#nextPage').click(function () {
        currentPage++;
        console.log(currentPage)
        const keyword = $('#searchInput').val().trim(); // Lấy giá trị input
        loadPromotions(currentPage, keyword);
    });

    // Tải trang đầu tiên khi load
    $(document).ready(function () {
        loadPromotions(0, "");
    });

    $(document).ready(function () {
        $('#search-icon').click(function() {
            const keyword = $('#searchInput').val().trim(); // Lấy giá trị input
            loadPromotions(currentPage, keyword);
        });

        $('#searchInput').keypress(function(event) {
            if (event.which === 13) { // Kiểm tra xem có phải phím Enter (13) không
                event.preventDefault(); // Ngăn chặn form submit
                const keyword = $('#searchInput').val().trim();
                // Gọi API tìm kiếm với từ khóa
                loadPromotions(currentPage, keyword);
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
