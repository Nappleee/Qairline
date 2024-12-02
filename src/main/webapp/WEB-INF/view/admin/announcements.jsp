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
    <link rel="stylesheet" href="/css/admin/announcement.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="/libs/simplebar/dist/simplebar.css">
    <link rel="stylesheet" href="/css/admin/icons/tabler-icons/tabler-icons.css">
</head>
<body>
<div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full" data-sidebar-position="fixed" data-header-position="fixed">

    <%@ include file="../share-view/admin_left_sidebar.jsp" %>


    <div class="body-wrapper">
        <%@ include file="../share-view/admin_header.jsp" %>

        <div class="container-fluid announcement-container">
            <h1>Announcement</h1>
            <div class="mt-4">
                <div class="add-announcement">
                    <div></div>
                    <a href="#" class="btn btn-secondary btn-add-announcement" data-bs-toggle="modal" data-bs-target="#addAnnouncementModal">
                        Add Announcement
                    </a>
                </div>
                <!-- Modal -->
                <div class="modal fade" id="addAnnouncementModal" tabindex="-1" aria-labelledby="addAnnouncementModalLabel" aria-hidden="true" style="display: none">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header d-flex justify-content-center">
                                <h5 class="modal-title" id="addAnnouncementModalLabel">Add Announcement</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <!-- Form for Adding Announcement -->
                                <%--@elvariable id="addAnnouncementModelAttribute" type=""--%>
                                <form:form id="addAnnouncementForm" method="post" action="/admin/announcements" modelAttribute="addAnnouncementModelAttribute">
                                    <div class="mb-3">
                                        <label for="title" class="form-label">Title</label>
                                        <input type="text" class="form-control" id="title" name="title" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="content" class="form-label">Content</label>
                                        <textarea class="form-control" id="content" name="content" rows="8" required></textarea>
                                    </div>

                                    <!-- Submit Button -->
                                    <div class="text-center">
                                        <button type="submit" class="btn btn-submit">Add Announcement</button>
                                    </div>
                                </form:form>
                            </div>

                        </div>
                    </div>
                </div>

                <!-- Edit Announcement Modal -->

                <!-- Edit Announcement Modal -->
                <div class="modal fade" id="editAnnouncementModal" tabindex="-1" aria-labelledby="editAnnouncementModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="editAnnouncementModalLabel">Edit Announcement</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form id="editAnnouncementForm">
                                    <div class="mb-3">
                                        <label for="editannouncementId" class="form-label">Announcement ID</label>
                                        <input type="text" id="editannouncementId" class="form-control" readonly />
                                    </div>
                                    <div class="mb-3">
                                        <label for="editAnnouncementTitle" class="form-label">Title</label>
                                        <input type="text" id="editAnnouncementTitle" name="editAnnouncementTitle" class="form-control" readonly />
                                    </div>
                                    <div class="mb-3">
                                        <label for="editContent" class="form-label">Content</label>
                                        <textarea class="form-control" id="editContent" name="editContent" rows="8" required></textarea>
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
                <span>${announcementsCount} records found</span>
            </div>
            <div class="mt-1">
                <div class="table-container">
                    <table class="table table-bordered" id="announcementsTable">
                        <thead class="table-header">
                        <tr>
                            <th>announcement ID</th>
                            <th>Title</th>
                            <th>Content</th>
                            <th>createdAt</th>
                            <th>updatedAt</th>
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
                            Are you sure you want to delete this announcement?
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
    function loadAnnouncements(Page, keyword) {
        console.log(Page);
        $.ajax({
            url: '/api/announcementsSearch?keyword=' + keyword + '&page='+ Page +'&size=5', // URL của REST API
            method: 'GET',
            dataType: 'json',
            success: function (data) {
                // Lặp qua danh sách announcements và thêm vào bảng
                const announcements = data.content;
                console.log(announcements);

                var rows = '';
                announcements.forEach(function (announcement) {
                    rows += '<tr>';
                    rows += '<td>' + announcement.announcementId + '</td>';
                    rows += '<td>' + announcement.title + '</td>';
                    rows += '<td>' + announcement.content + '</td>';
                    rows += '<td>' + announcement.createdAt + '</td>';
                    rows += '<td>' + announcement.updatedAt + '</td>';
                    rows += '<td class="text-center"><a class="btn-edit" onclick="Edit('+ announcement.announcementId + ')">Edit</a> / <a class="btn-edit" onclick="confirmDelete('+ announcement.announcementId + ')">Remove</a></td>';
                    rows += '</tr>';
                });
                // console.log(rows);
                $('#announcementsTable tbody').html(rows);

                $('#currentPage').text(`Page: ` + (data.number + 1));
                $('#prevPage').prop('disabled', data.first);
                $('#nextPage').prop('disabled', data.last);
            },
            error: function (xhr, status, error) {
                console.error('Error fetching announcements:', status, error);
                console.error('Response:', xhr.responseText);
            }
        });
    };

    let announcementIdToDelete = null; // Biến để lưu ID chuyến bay cần xóa

    // Hàm gọi khi người dùng nhấn nút xóa
    function confirmDelete(announcementId) {
        announcementIdToDelete = announcementId; // Lưu ID chuyến bay cần xóa
        $('#deleteConfirmModal').modal('show'); // Hiển thị modal xác nhận
    }

    // Hàm thực hiện xóa khi người dùng chọn "Yes"
    $('#confirmDeleteButton').click(function() {
        console.log(announcementIdToDelete);
        if (announcementIdToDelete != null) {
            // Gửi yêu cầu xóa chuyến bay bằng AJAX
            $.ajax({
                url: '/api/deleteannouncement', // Đường dẫn API để xóa
                method: 'POST',
                data: { announcementId: announcementIdToDelete },
                success: function(response) {
                    $('#deleteConfirmModal').modal('hide');
                    location.reload();
                },
                error: function() {
                    console.log('Error occurred while deleting announcement.');
                }
            });
        }
    });

    // Hàm mở modal và điền thông tin chuyến bay vào form
    function Edit(announcementId) {
        // Gửi yêu cầu GET để lấy thông tin chuyến bay từ server
        console.log("edit");
        $.ajax({
            url: '/api/announcements/' + announcementId,  // API lấy thông tin chuyến bay
            method: 'GET',
            dataType: 'json',
            success: function(data) {
                // Điền thông tin vào các trường trong form modal
                $('#editannouncementId').val(data.announcementId);  // announcement ID
                $('#editAnnouncementTitle').val(data.title);
                $('#editContent').val(data.content);


                // Hiển thị modal
                $('#editAnnouncementModal').modal('show');
            },
            error: function(error) {
                console.error('Error fetching announcement data:', error);
            }
        });
    }



    $('#editAnnouncementForm').on('submit', function(e) {
        e.preventDefault();

        const announcementId = $('#editannouncementId').val();
        const title = $('#editAnnouncementTitle').val();
        const content = $('#editContent').val();
        console.log(announcementId);
        // Gửi yêu cầu PUT để cập nhật chuyến bay
        $.ajax({
            url: '/api/announcements/' + announcementId,
            method: 'POST',
            data: JSON.stringify({
                announcementId: announcementId,
                title: title,
                content: content,
            }),
            contentType: 'application/json',
            dataType: 'json',
            success: function(response) {
                // Cập nhật giao diện sau khi chỉnh sửa thành công
                $('#announcementsTable tbody').empty();
                location.reload() // Tải lại dữ liệu sau khi chỉnh sửa
                $('#editannouncementModal').modal('hide'); // Đóng modal
            },
            error: function(error) {
                console.error('Error updating announcement:', error);
            }
        });
    });

    $(document).ready(function() {
        $('#addAnnouncementForm').submit(function(event) {
            event.preventDefault(); // Ngừng việc submit form truyền thống
            console.log(12345);
            var formData = $(this).serialize(); // Lấy dữ liệu từ form
            console.log(formData)
            $.ajax({
                url: '/admin/announcements', // Đường dẫn tới controller
                type: 'POST',
                data: formData,
                success: function(response) {
                    console.log(response);
                    if (response == "success") {
                        location.reload();

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
            loadAnnouncements(currentPage, keyword);
        }
    });

    // Nút Next
    $('#nextPage').click(function () {
        currentPage++;
        console.log(currentPage)
        const keyword = $('#searchInput').val().trim(); // Lấy giá trị input
        loadAnnouncements(currentPage, keyword);
    });

    // Tải trang đầu tiên khi load
    $(document).ready(function () {
        loadAnnouncements(0, "");
    });

    $(document).ready(function () {
        $('#search-icon').click(function() {
            const keyword = $('#searchInput').val().trim(); // Lấy giá trị input
            loadAnnouncements(currentPage, keyword);
        });

        $('#searchInput').keypress(function(event) {
            if (event.which === 13) { // Kiểm tra xem có phải phím Enter (13) không
                event.preventDefault(); // Ngăn chặn form submit
                const keyword = $('#searchInput').val().trim();
                loadAnnouncements(currentPage, keyword);
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