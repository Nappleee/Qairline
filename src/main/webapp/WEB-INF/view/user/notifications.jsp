<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">
        <title>Notification (JSON EXAMPLE)</title>
        <title>Notification</title>


        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Jost:wght@500;600&family=Roboto&display=swap" rel="stylesheet">

        <!-- Icon Font Stylesheet -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="${pageContext.request.contextPath}/libs/owlcarousel/assets/owl.carousel.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/libs/lightbox/css/lightbox.css" rel="stylesheet">


        <!-- Customized Bootstrap Stylesheet -->
        <link href="${pageContext.request.contextPath}/libs/bootstrap/dist/css/bootstrap.css" rel="stylesheet">

        <!-- stylesheet-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user/notification.css">
    </head>
    <body>

        <%@ include file="../share-view/user-header.jsp" %>

        <!-- Header Start -->
        <div class="container-fluid bg-breadcrumb">
            <div class="container text-center py-5" style="max-width: 900px; height: 400px;">
                <h3 class="text-white display-3 mb-4">BangBang Airline</h3>

            </div>
        </div>
        <!-- Header End -->

        <div id="searchContainer" class="container-fluid search-bar py-5" style="top: -50%">
            <div class="container bg-light p-4 rounded">
                <!-- Phân loại chuyến đi -->
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <!-- Một chiều -->
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="tripType" id="oneWay" value="oneWay"
                               onclick="checkedForm(this)">
                        <label class="form-check-label" for="oneWay">Một chiều</label>
                    </div>

                    <!-- Khứ hồi -->
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="tripType" id="roundTrip" value="roundTrip"
                               onclick="checkedForm(this)">
                        <label class="form-check-label" for="roundTrip">Khứ hồi</label>
                    </div>

                    <!-- Đa chặng -->
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="tripType" id="multiCity" value="multiCity"
                               onclick="checkedForm(this)">
                        <label class="form-check-label" for="multiCity">Đa chặng</label>
                    </div>
                </div>


                <!-- Thông tin tìm kiếm -->
                <div class="row g-3">
                    <!-- Điểm đi -->
                    <div class="col-md-6 col-lg-3">
                        <label for="departure" class="form-label fw-bold">Từ</label>
                        <input id="departure" type="text" class="searchLocation form-select rounded-pill"
                               name="location" placeholder="Nhập tên thành phố...">
                    </div>
                    <!-- Điểm đến -->
                    <div class="col-md-6 col-lg-3">
                        <label for="destination" class="form-label fw-bold">Đến</label>
                        <input id="destination" type="text" class="searchLocation form-select rounded-pill"
                               name="location" placeholder="Nhập tên thành phố...">
                    </div>

                    <!-- Ngày đi -->
                    <div class="col-md-6 col-lg-3">
                        <label for="departure_time" class="form-label">Ngày đi</label>
                        <input type="date" class="form-control rounded-pill" id="departure_time">
                    </div>
                    <!-- Ngày về -->
                    <div class="col-md-6 col-lg-3">
                        <label for="returnDate" class="form-label">Ngày về</label>
                        <input type="date" class="form-control rounded-pill" id="returnDate">
                    </div>
                </div>

                <!-- Số hành khách -->
                <div class="row mt-3">
                    <div class="col-md-6 col-lg-3">
                        <label for="passengers" class="form-label">Số hành khách</label>
                        <select id="passengers" class="form-select rounded-pill">
                            <option value="1">1 Hành khách</option>
                            <option value="2">2 Hành khách</option>
                            <option value="3">3 Hành khách</option>
                            <option value="4">4+ Hành khách</option>
                        </select>
                    </div>

                    <!-- Mã giảm giá -->
                    <div class="col-md-6 col-lg-3">
                        <label for="promoCode" class="form-label">Mã giảm giá</label>
                        <input type="text" class="form-control rounded-pill" id="promoCode"
                               placeholder="Nhập mã giảm giá">
                    </div>

                    <!-- Nút tìm kiếm -->
                    <div class="col-lg-6 d-flex align-items-end">
                        <button id="finding" type="button" class="btn btn-primary w-100 rounded-pill py-2"
                                onclick="findingAirplane()">
                            Tìm chuyến bay
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal hiển thị chuyến bay -->
        <div class="modal fade" id="flightModal" tabindex="-1" aria-labelledby="flightModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="flightModalLabel">Danh sách chuyến bay</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <!-- Danh sách chuyến bay -->
                        <div id="flightsList" class="d-flex flex-column gap-3">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        <button type="button" class="btn btn-primary">Tiếp tục</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- About Start -->
        <div class="container-fluid about py-5">
            <div class="container py-5">
                <div class="row g-5 align-items-center">
                    <div class="col-lg-5">
                        <div class="h-100" style="border: 50px solid; border-color: transparent #13357B transparent #13357B;">
                            <img src="/images/user/about-img.jpg" class="img-fluid w-100 h-100" alt="">
                        </div>
                    </div>
                    <div class="col-lg-7" style="background: linear-gradient(rgba(255, 255, 255, .8), rgba(255, 255, 255, .8)), url(../../../resources/images/user/about-img-1.png);">
                        <h5 class="section-about-title pe-3">About Us</h5>
                        <h1 class="mb-4">Welcome to <span class="text-primary">Travela</span></h1>
                        <p class="mb-4">Lorem ipsum dolor sit amet consectetur adipisicing elit. Molestias, dolorum, doloribus sunt dicta, officia voluptatibus libero necessitatibus natus impedit quam ullam assumenda? Id atque iste consectetur. Commodi odit ab saepe!</p>
                        <p class="mb-4">Lorem ipsum dolor sit amet consectetur adipisicing elit. Accusantium quos voluptatem suscipit neque enim, doloribus ipsum rem eos distinctio, dignissimos nisi saepe nulla? Libero numquam perferendis provident placeat molestiae quia?</p>
                        <div class="row gy-2 gx-4 mb-4">
                            <div class="col-sm-6">
                                <p class="mb-0"><i class="fa fa-arrow-right text-primary me-2"></i>First Class Flights</p>
                            </div>
                            <div class="col-sm-6">
                                <p class="mb-0"><i class="fa fa-arrow-right text-primary me-2"></i>Handpicked Hotels</p>
                            </div>
                            <div class="col-sm-6">
                                <p class="mb-0"><i class="fa fa-arrow-right text-primary me-2"></i>5 Star Accommodations</p>
                            </div>
                            <div class="col-sm-6">
                                <p class="mb-0"><i class="fa fa-arrow-right text-primary me-2"></i>Latest Model Vehicles</p>
                            </div>
                            <div class="col-sm-6">
                                <p class="mb-0"><i class="fa fa-arrow-right text-primary me-2"></i>150 Premium City Tours</p>
                            </div>
                            <div class="col-sm-6">
                                <p class="mb-0"><i class="fa fa-arrow-right text-primary me-2"></i>24/7 Service</p>
                            </div>
                        </div>
                        <a class="btn btn-primary rounded-pill py-3 px-5 mt-2" href="">Read More</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- About End -->

        <!-- Travel Guide Start -->
        <div class="container-fluid guide py-5">
            <div class="container py-5">
                <div class="mx-auto text-center mb-5" style="max-width: 900px;">
                    <h5 class="section-title px-3">Travel Guide</h5>
                    <h1 class="mb-0">Meet Our Guide</h1>
                </div>
                <div class="row g-4">
                    <div class="col-md-6 col-lg-3">
                        <div class="guide-item">
                            <div class="guide-img">
                                <div class="guide-img-efects">
                                    <img src="/images/user/guide-1.jpg" class="img-fluid w-100 rounded-top" alt="Image">
                                </div>
                                <div class="guide-icon rounded-pill p-2">
                                    <a class="btn btn-square btn-primary rounded-circle mx-1" href=""><i class="fab fa-facebook-f"></i></a>
                                    <a class="btn btn-square btn-primary rounded-circle mx-1" href=""><i class="fab fa-twitter"></i></a>
                                    <a class="btn btn-square btn-primary rounded-circle mx-1" href=""><i class="fab fa-instagram"></i></a>
                                    <a class="btn btn-square btn-primary rounded-circle mx-1" href=""><i class="fab fa-linkedin-in"></i></a>
                                </div>
                            </div>
                            <div class="guide-title text-center rounded-bottom p-4">
                                <div class="guide-title-inner">
                                    <h4 class="mt-3">Full Name</h4>
                                    <p class="mb-0">Designation</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                        <div class="guide-item">
                            <div class="guide-img">
                                <div class="guide-img-efects">
                                    <img src="/images/user/guide-2.jpg" class="img-fluid w-100 rounded-top" alt="Image">
                                </div>
                                <div class="guide-icon rounded-pill p-2">
                                    <a class="btn btn-square btn-primary rounded-circle mx-1" href=""><i class="fab fa-facebook-f"></i></a>
                                    <a class="btn btn-square btn-primary rounded-circle mx-1" href=""><i class="fab fa-twitter"></i></a>
                                    <a class="btn btn-square btn-primary rounded-circle mx-1" href=""><i class="fab fa-instagram"></i></a>
                                    <a class="btn btn-square btn-primary rounded-circle mx-1" href=""><i class="fab fa-linkedin-in"></i></a>
                                </div>
                            </div>
                            <div class="guide-title text-center rounded-bottom p-4">
                                <div class="guide-title-inner">
                                    <h4 class="mt-3">Full Name</h4>
                                    <p class="mb-0">Designation</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                        <div class="guide-item">
                            <div class="guide-img">
                                <div class="guide-img-efects">
                                    <img src="/images/user/guide-3.jpg" class="img-fluid w-100 rounded-top" alt="Image">
                                </div>
                                <div class="guide-icon rounded-pill p-2">
                                    <a class="btn btn-square btn-primary rounded-circle mx-1" href=""><i class="fab fa-facebook-f"></i></a>
                                    <a class="btn btn-square btn-primary rounded-circle mx-1" href=""><i class="fab fa-twitter"></i></a>
                                    <a class="btn btn-square btn-primary rounded-circle mx-1" href=""><i class="fab fa-instagram"></i></a>
                                    <a class="btn btn-square btn-primary rounded-circle mx-1" href=""><i class="fab fa-linkedin-in"></i></a>
                                </div>
                            </div>
                            <div class="guide-title text-center rounded-bottom p-4">
                                <div class="guide-title-inner">
                                    <h4 class="mt-3">Full Name</h4>
                                    <p class="mb-0">Designation</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                        <div class="guide-item">
                            <div class="guide-img">
                                <div class="guide-img-efects">
                                    <img src="/images/user/guide-4.jpg" class="img-fluid w-100 rounded-top" alt="Image">
                                </div>
                                <div class="guide-icon rounded-pill p-2">
                                    <a class="btn btn-square btn-primary rounded-circle mx-1" href=""><i class="fab fa-facebook-f"></i></a>
                                    <a class="btn btn-square btn-primary rounded-circle mx-1" href=""><i class="fab fa-twitter"></i></a>
                                    <a class="btn btn-square btn-primary rounded-circle mx-1" href=""><i class="fab fa-instagram"></i></a>
                                    <a class="btn btn-square btn-primary rounded-circle mx-1" href=""><i class="fab fa-linkedin-in"></i></a>
                                </div>
                            </div>
                            <div class="guide-title text-center rounded-bottom p-4">
                                <div class="guide-title-inner">
                                    <h4 class="mt-3">Full Name</h4>
                                    <p class="mb-0">Designation</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Travel Guide End -->

        <!-- Subscribe Start -->
        <div class="container-fluid subscribe py-5">
            <div class="container text-center py-5">
                <div class="mx-auto text-center" style="max-width: 900px;">
                    <h5 class="subscribe-title px-3">Subscribe</h5>
                    <h1 class="text-white mb-4">Our Newsletter</h1>
                    <p class="text-white mb-5">Lorem ipsum dolor sit amet consectetur adipisicing elit. Laborum tempore nam, architecto doloremque velit explicabo? Voluptate sunt eveniet fuga eligendi! Expedita laudantium fugiat corrupti eum cum repellat a laborum quasi.
                    </p>
                    <div class="position-relative mx-auto">
                        <input class="form-control border-primary rounded-pill w-100 py-3 ps-4 pe-5" type="text" placeholder="Your email">
                        <button type="button" class="btn btn-primary rounded-pill position-absolute top-0 end-0 py-2 px-4 mt-2 me-2">Subscribe</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Subscribe End -->


        <%@ include file="../share-view/user-footer.jsp" %>


        <!--script stuffs-->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="/libs/bootstrap/dist/js/bootstrap.bundle.js"></script>
        <script src="/libs/easing/easing.min.js"></script>
        <script src="/libs/waypoints/waypoints.min.js"></script>
        <script src="/libs/owlcarousel/owl.carousel.min.js"></script>
        <script src="/libs/lightbox/js/lightbox.min.js"></script>
        <script src="/js/notification.js"></script>
        <script>

            $(document).ready(function() {
                $.ajax({
                    url: '/api/getAllPromotions', //URL của REST API
                    method: 'GET',
                    dataType: 'json',headers: {
                        'Authorization': 'Bearer ' + localStorage.getItem('accessToken')  // Lấy token từ localStorage
                    },
                    success: function(data) {
                        console.log("3");
                        // Duyệt qua danh sách máy bay và thêm mỗi model vào select
                        $.each(data, function(index, promotion) {
                            $('#notificationContent').append('<a class = "dropdown-item">' + promotion.title + '</a>');
                            console.log(2);
                        });
                    },
                    error: function (error) {
                        console.error('Error fetching aircraft:', error);
                        window.location.href = '/admin/deny';
                    }
                });
            });


            <%--function showNotificationBox(promotions) {--%>
            <%--    const notificationBox = document.getElementById('notificationBox');--%>
            <%--    const notificationContent = document.getElementById('notificationContent');--%>

            <%--    // Xóa nội dung cũ--%>
            <%--    notificationContent.innerHTML = '';--%>

            <%--    // Hiển thị danh sách promotions--%>
            <%--    promotions.forEach(promotion => {--%>
            <%--        const promotionItem = document.createElement('a');--%>
            <%--        promotionItem.className = 'dropdown-item';--%>
            <%--        promotionItem.textContent = promotion.description;--%>
            <%--        promotionItem.onclick = () => {--%>
            <%--            window.location.href = `/booking?promotionId=${promotion.promotionId}`;--%>
            <%--        };--%>
            <%--        notificationContent.appendChild(promotionItem);--%>
            <%--    });--%>

            <%--    // Hiển thị hộp thông báo--%>
            <%--    notificationBox.style.display = 'block';--%>
            <%--}--%>

            // Hàm đóng hộp thông báo
            function closeNotificationBox() {
                document.getElementById('notificationBox').style.display = 'none';
            }

            // Ví dụ sử dụng (khi gọi API thành công)
            // Đây chỉ là dữ liệu mẫu
            // const promotionsSample = [
            //     { promotionId: 1, description: 'Black Friday Sale', discountPercent: 50 },
            //     { promotionId: 2, description: 'Cyber Monday', discountPercent: 30 },
            //     { promotionId: 3, description: 'Christmas Deals', discountPercent: 20 }
            // ];

            // Hiển thị thông báo mẫu sau 2 giâ
        </script>
    </div>
    </body>
</html>