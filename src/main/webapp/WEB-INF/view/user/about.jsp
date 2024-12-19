<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html >
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giới thiệu Qairline</title>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Libraries Stylesheet -->
    <link href="${pageContext.request.contextPath}/libs/owlcarousel/assets/owl.carousel.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/libs/lightbox/css/lightbox.min.css" rel="stylesheet">


    <!-- Customized Bootstrap Stylesheet -->
    <link href="${pageContext.request.contextPath}/libs/bootstrap/dist/css/bootstrap.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user/home.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            color: #333;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .text-center {
            text-align: center;
        }
        .hero {
            background-image: url('${pageContext.request.contextPath}/images/qairline-hero.jpg');
            background-size: cover;
            background-position: center;
            color: white;
            padding: 80px 20px;
            border-radius: 8px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }
        .hero h1 {
            font-size: 48px;
            margin-bottom: 20px;
        }
        .hero p {
            font-size: 20px;
        }
        .content-section {
            margin-top: 40px;
        }
        .content-section h2 {
            font-size: 28px;
            margin-bottom: 15px;
            color: #007bff;
        }
        .content-section p {
            font-size: 18px;
            line-height: 1.6;
            margin-bottom: 20px;
        }
        .features {
            display: flex;
            gap: 20px;
            margin-top: 30px;
        }
        .feature {
            flex: 1;
            background: #007bff;
            color: white;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
        }
        .feature h3 {
            font-size: 22px;
            margin-bottom: 10px;
        }
        .feature p {
            font-size: 16px;
        }
        .footer {
            text-align: center;
            margin-top: 50px;
            font-size: 14px;
            color: #777;
        }
    </style>
</head>
<body>
<%@ include file="../share-view/user-header.jsp" %>
<div class="container">
    <div class="hero text-center">
        <h1>Về Qairline</h1>
        <p>Hãng hàng không đẳng cấp, đồng hành cùng bạn trên mọi chặng đường.</p>
    </div>

    <div class="content-section">
        <h2>Lịch sử hình thành</h2>
        <p>Qairline được thành lập bởi ba sinh viên tài năng của Đại học Công nghệ (UET) với mục tiêu mang đến sự đổi mới trong ngành hàng không. Từ những ngày đầu tiên, chúng tôi đã không ngừng nỗ lực để xây dựng một hãng hàng không hiện đại, lấy khách hàng làm trung tâm.</p>

        <h2>Sứ mệnh và tầm nhìn</h2>
        <p>Sứ mệnh của chúng tôi là mang đến cho hành khách trải nghiệm bay an toàn, tiện nghi và đầy cảm hứng. Với tầm nhìn trở thành hãng hàng không hàng đầu khu vực, Qairline cam kết không ngừng cải tiến và đổi mới dịch vụ.</p>

        <h2>Dịch vụ của chúng tôi</h2>
        <div class="features">
            <div class="feature">
                <h3>Chuyến bay nội địa</h3>
                <p>Khám phá mọi miền đất nước với các chuyến bay nhanh chóng và thuận tiện.</p>
            </div>
            <div class="feature">
                <h3>Chuyến bay quốc tế</h3>
                <p>Kết nối bạn với hơn 100 điểm đến trên toàn thế giới.</p>
            </div>
            <div class="feature">
                <h3>Dịch vụ hạng thương gia</h3>
                <p>Tận hưởng sự thoải mái và đẳng cấp với dịch vụ hạng thương gia của chúng tôi.</p>
            </div>
        </div>

        <h2>Đội ngũ của chúng tôi</h2>
        <p>Qairline sở hữu đội ngũ nhân viên tận tâm và chuyên nghiệp, luôn sẵn sàng phục vụ và hỗ trợ hành khách. Từ phi hành đoàn đến bộ phận hỗ trợ khách hàng, tất cả đều được đào tạo kỹ lưỡng để mang lại sự hài lòng tối đa.</p>

        <h2>Hãy cùng bay!</h2>
        <p>Chúng tôi rất vinh dự khi trở thành một phần trong hành trình của bạn. Hãy cùng Qairline khám phá thế giới và tạo nên những kỷ niệm đáng nhớ.</p>
    </div>


</div>
<%@ include file="../share-view/user-footer.jsp" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</body>
</html>
