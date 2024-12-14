<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tìm kiếm chuyến bay</title>
    <!-- Bootstrap CSS -->
    <link href="${pageContext.request.contextPath}/libs/bootstrap/dist/css/bootstrap.css" rel="stylesheet">
    <style>
        /* Modal Wrapper */
        .custom-modal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.6);
            display: none;  /* Ẩn mặc định */
            z-index: 1000;
            opacity: 0;
            transition: opacity 0.3s ease-in-out;
        }

        .custom-modal.show {
            display: block;
            opacity: 1;
        }

        /* Modal Content */
        .custom-modal-content {
            background-color: white;
            margin: 10% auto;
            padding: 30px;
            border-radius: 15px;
            width: 80%;
            max-width: 600px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
            transform: scale(0.9);
            transition: transform 0.3s ease-in-out;
        }

        .custom-modal.show .custom-modal-content {
            transform: scale(1);
        }

        /* Close Button */
        .custom-close {
            color: #aaa;
            font-size: 30px;
            font-weight: bold;
            position: absolute;
            top: 10px;
            right: 20px;
            cursor: pointer;
        }

        .custom-close:hover,
        .custom-close:focus {
            color: #333;
            text-decoration: none;
        }

        /* Ticket Information */
        .custom-ticket-info h6 {
            font-size: 20px;
            color: #34495e;
            margin-bottom: 10px;
        }

        .custom-ticket-info p {
            font-size: 18px;
            color: #7f8c8d;
            margin: 5px 0;
        }

        /* buy Button */
        .custom-buy-button {
            background-color: #e74c3c;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.3s;
        }

        .custom-buy-button:hover {
            background-color: #c0392b;
        }

        /* Navigation Buttons */
        .custom-nav-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }

        .custom-nav-button {
            background-color: #3498db;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 50%;
            cursor: pointer;
            width: 50px;
            height: 50px;
            font-size: 18px;
            transition: background-color 0.3s;
        }

        .custom-nav-button:hover {
            background-color: #2980b9;
        }

        .custom-prev-button {
            background-color: #f39c12;
        }

        .custom-prev-button:hover {
            background-color: #e67e22;
        }

        .custom-next-button {
            background-color: #2ecc71;
        }

        .custom-next-button:hover {
            background-color: #27ae60;
        }

        .suggestion-box {
            border: 1px solid #ddd;
            background-color: white;
            position: absolute;
            max-height: 150px;
            overflow-y: auto;
            z-index: 10;
            width: 100%;
            margin-top: 5px;
        }
        .suggestion-item {
            padding: 8px;
            cursor: pointer;
        }
        .suggestion-item:hover {
            background-color: #f0f0f0;
        }
        /* Flight Card Styles */
        .flight-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        /* Card style */
        .flight-card {
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 100%;
            max-width: 800px;
            margin: 0 auto;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            position: relative;
        }

        /* Hover effect on card */
        .flight-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
        }

        .flight-card h6 {
            font-size: 18px;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 10px;
        }

        .flight-card p {
            font-size: 16px;
            color: #7f8c8d;
            margin: 8px 0;
        }

        .flight-card .flight-departure,
        .flight-card .flight-price {
            font-weight: bold;
            color: #2980b9;
        }

        .flight-card .flight-price {
            font-size: 18px;
            color: #e74c3c;
        }

        /* Arrow for dropdown */
        .flight-card .toggle-arrow {
            font-size: 18px;
            color: #2980b9;
            cursor: pointer;
            position: absolute;
            bottom: 20px;
            right: 20px;
            transition: transform 0.3s ease;
        }

        /* Rotate arrow when dropdown is open */
        .flight-card.open .toggle-arrow {
            transform: rotate(180deg);
        }

        /* Dropdown content */
        .flight-card .dropdown-content {
            display: none;
            background-color: #f1f1f1;
            padding: 15px;
            border-radius: 10px;
            margin-top: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: height 0.3s ease;
        }

        /* Show dropdown when open */
        .flight-card.open .dropdown-content {
            display: block;
        }

        /* Additional information */
        .flight-card .dropdown-content p {
            font-size: 14px;
            color: #34495e;
        }

        .flight-card .buy-button {
            background-color: #27ae60;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
            font-size: 16px;
            width: 100%;
            margin-top: 10px;
            transition: background-color 0.3s ease;
        }

        .flight-card .buy-button:hover {
            background-color: #2ecc71;
        }

        /* Responsive design */
        @media (max-width: 768px) {
            .flight-card {
                width: 100%;
                margin-bottom: 20px;
            }
        }
    </style>
</head>
<body>
<div class="container bg-light p-4 rounded">
    <!-- Flight Search Form -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <div class="form-check">
            <input class="form-check-input" type="radio" name="tripType" id="oneWay" value="oneWay" onclick="checkedForm(this)">
            <label class="form-check-label" for="oneWay">Một chiều</label>
        </div>
        <div class="form-check">
            <input class="form-check-input" type="radio" name="tripType" id="roundTrip" value="roundTrip" onclick="checkedForm(this)">
            <label class="form-check-label" for="roundTrip">Khứ hồi</label>
        </div>
        <div class="form-check">
            <input class="form-check-input" type="radio" name="tripType" id="multiCity" value="multiCity" onclick="checkedForm(this)">
            <label class="form-check-label" for="multiCity">Đa chặng</label>
        </div>
    </div>

    <!-- Search Form Fields -->
    <div class="row g-3">
        <div class="col-md-6 col-lg-3">
            <label for="departure" class="form-label fw-bold">Từ</label>
            <input id="departure" type="text" class="searchLocation form-select rounded-pill" name="location" placeholder="Nhập tên thành phố...">
        </div>
        <div class="col-md-6 col-lg-3">
            <label for="destination" class="form-label fw-bold">Đến</label>
            <input id="destination" type="text" class="searchLocation form-select rounded-pill" name="location" placeholder="Nhập tên thành phố...">
        </div>
        <div class="col-md-6 col-lg-3">
            <label for="departure_time" class="form-label">Ngày đi</label>
            <input type="date" class="form-control rounded-pill" id="departure_time">
        </div>

    </div>
    <div class="row mt-3">
        <div class="col-lg-6 d-flex align-items-end">
            <button id="finding" type="button" class="btn btn-primary w-100 rounded-pill py-2" onclick="findingAirplane()">
                Tìm chuyến bay
            </button>
        </div>
    </div>
</div>

<div id="flightsList" class="container mt-4"></div>
<!-- Thẻ container cho vé sẽ hiển thị sau khi người dùng tìm kiếm vé -->
<div id="ticket-container"></div>
<!-- JavaScript -->
<script>
    var Page = 0;
    let airportCityMap = new Map([['SGN', 'Ho Chi Minh City'], ['HAN', 'Hanoi'], ['JFK', 'New York'], ['LHR', 'London'], ['DXB', 'Dubai']]);

    var customer = {
        typeOfFlight: "One-way",
        departure: "",
        destination: "",
        departure_time: "",
        returnDate: "",
        passengers: 1,
        promoCode: ""
    };

    function formatDate(dateString) {
        // Loại bỏ thẻ <br> và chuyển đổi chuỗi thành định dạng hợp lệ
        const cleanedDateString = dateString.replace('<br>', ' ');

        // Chuyển chuỗi đã làm sạch thành đối tượng Date
        const date = new Date(cleanedDateString);

        // Kiểm tra xem có phải là ngày hợp lệ không
        if (isNaN(date)) {
            return "Invalid date";  // Nếu không hợp lệ, trả về lỗi
        }

        // Trả về ngày tháng theo định dạng hiện tại của trình duyệt
        return date.toLocaleString();
    }

    function findingAirplane() {
        gettingCustomerRequest();
        var keyword = customer.departure;
        var destination = customer.destination
        $.ajax({
            url: '/api/flightsSearch?keyword=' + keyword + '&page=' + Page + '&size=5',
            method: 'GET',
            dataType: 'json',
            headers: {
                'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
            },
            success: function (data) {
                const flights = data.content;
                displayFlights(flights);
            },
            error: function (error) {
                alert('Could not fetch flights. Please try again later.');
            }
        });
    }

    function gettingCustomerRequest() {
        customer.departure = airportCityMap.get(document.getElementById("departure").value) || document.getElementById("departure").value;
        customer.destination = airportCityMap.get(document.getElementById("destination").value) || document.getElementById("destination").value;
        customer.departure_time = document.getElementById("departure_time").value;
        //customer.returnDate = document.getElementById("returnDate").value;
        //customer.passengers = document.getElementById("passengers").value;
        //customer.promoCode = document.getElementById("promoCode").value;
    }

    function displayFlights(flights) {
        const flightsList = document.getElementById('flightsList');
        flightsList.innerHTML = '';
        if (flights.length === 0) {
            flightsList.innerHTML = `<p>No flights found matching your criteria.</p>`;
            return;
        }

        let flightHTML = '';
        var destination = customer.destination
        flights.forEach(flight => {
            const formattedTime = formatDate(flight.departureTime);
            console.log(flight.departureTime, customer.departure_time);
            let flightTimeObj = new Date(formattedTime);
            let customerTimeObj = new Date(customer.departure_time);
            if (flightTimeObj < customerTimeObj) {
                console.log("quá giờ bay của chuyến bay");
            } else {
                console.log("chưa đến giờ bay của chuyến bay");
            }
            if (flight.destination == destination && flightTimeObj >= customerTimeObj) {

                flightHTML += '<div class="flight-card">';
                flightHTML += '<h6>Flight ID: ' + flight.flightId + '</h6>';
                flightHTML += '<p>' + flight.departure + ' → ' + flight.destination + '</p>';
                flightHTML += '<p class="flight-departure">Departure: ' + formattedTime + '</p>';
                flightHTML += '<p class="flight-price">Price: ' + flight.ticketPrice.toLocaleString() + ' VND</p>';
                flightHTML += '<div class="toggle-arrow">&#9660;</div>'; // mũi tên
                flightHTML += '<div class="dropdown-content">';
                flightHTML += '<p>Quyền lợi: Bảo hiểm chuyến bay, hủy vé miễn phí</p>';
                flightHTML += '<p>Số hành lý: 20kg xách tay</p>';
                flightHTML += '<button class="buy-button" onclick="searchTicket(' + flight.flightId + ')">Mua vé</button>'
                flightHTML += '</div>';
                flightHTML += '</div>';

            }
        });

        flightsList.innerHTML = flightHTML;


        // Thêm sự kiện mở/đóng dropdown
        document.querySelectorAll('.toggle-arrow').forEach(arrow => {
            arrow.addEventListener('click', function () {
                const card = arrow.closest('.flight-card');
                card.classList.toggle('open');
            });
        });
    }

    function searchTicket(flightId) {
        $.ajax({
            url: '/api/getAllTickets',
            method: 'GET',
            dataType: 'json',
            headers: {
                'Authorization': 'Bearer ' + localStorage.getItem('accessToken')  // Đảm bảo bạn có token hợp lệ
            },
            success: function (data) {
                console.log(data, "Abc");  // Hiển thị dữ liệu trả về trong console
                displayTickets(data, flightId);  // Gọi hàm để hiển thị các vé
            },
            error: function (error) {
                console.error('Error fetching tickets:', error);
                alert('Could not fetch tickets. Please try again later.');
            }
        });
    }


    // Hàm để hiển thị vé (tùy chỉnh theo giao diện của bạn)
    let currentTicketIndex = 0;

    function displayTickets(tickets, flightId) {
        console.log(currentTicketIndex,tickets[currentTicketIndex],"Abcddefe");
        tickets = ticketFilter(tickets, flightId);
        console.log(tickets.size, typeof(tickets));
        if (tickets.length === 0) {
            alert('Không còn vé khác.');
        }
        else {
            const ticketContainer = document.getElementById('ticket-container');
            ticketContainer.innerHTML = '';  // Xóa nội dung cũ nếu có
            const modal = document.createElement('div');
            modal.classList.add('custom-modal');
            modal.classList.add('show');
            // Đảm bảo modal hiển thị ngay lập tức

            const modalContent = document.createElement('div');
            modalContent.classList.add('custom-modal-content');


            // Tạo phần tử đóng modal
            const closeButton = document.createElement('span');
            closeButton.classList.add('custom-close');

            closeButton.innerText = '×';
            closeButton.onclick = function () {
                modal.classList.remove('show');  // Ẩn modal khi đóng
            };
            modalContent.appendChild(closeButton);

            // Hiển thị thông tin vé
            const ticketId = document.createElement('h6');
            ticketId.innerText = 'Ticket ID: ' + tickets[currentTicketIndex].ticketId;
            modalContent.appendChild(ticketId);

            const flightInfo = document.createElement('p');
            flightInfo.innerText = 'Flight ID: ' + tickets[currentTicketIndex].flightId;
            modalContent.appendChild(flightInfo);

            const status = document.createElement('p');
            status.innerText = 'status: ' + tickets[currentTicketIndex].status;
            modalContent.appendChild(status);

            const ticketPrice = document.createElement('p');
            ticketPrice.innerText = 'Price: ' + tickets[currentTicketIndex].finalPrice.toLocaleString() + ' VND';
            modalContent.appendChild(ticketPrice);

            const buyButton = document.createElement('button');
            buyButton.classList.add('custom-buy-button');

            buyButton.innerText = 'Buy Ticket';
            buyButton.setAttribute('onclick', 'buyTicket(' + tickets[currentTicketIndex].ticketId + ')');
            modalContent.appendChild(buyButton);

            // Nút Next và Previous với mũi tên
            const prevButton = document.createElement('button');
            prevButton.classList.add('custom-nav-button', 'custom-prev-button');
            prevButton.innerHTML = '&#8592;';
            prevButton.onclick = function () {
                console.log(currentTicketIndex);
                currentTicketIndex = (currentTicketIndex === 0) ? tickets.length - 1 : currentTicketIndex - 1;
                console.log(currentTicketIndex);
                displayTickets(tickets, modalContent);
            };
            modalContent.appendChild(prevButton);

            const nextButton = document.createElement('button');
            nextButton.classList.add('custom-nav-button', 'custom-next-button');
            nextButton.innerHTML = '&#8594;';
            nextButton.onclick = function () {
                currentTicketIndex = (currentTicketIndex === tickets.length - 1) ? 0 : currentTicketIndex + 1;
                displayTickets(tickets, modalContent);
            };
            modalContent.appendChild(nextButton);

            modal.appendChild(modalContent);
            ticketContainer.appendChild(modal);
        }
    }

    function ticketFilter(tickets, flightId) {
        // Lọc các vé có status là 'AVAILABLE' và flightId phù hợp
        return tickets.filter(ticket =>
            ticket.status === 'AVAILABLE' &&
            ticket.flightId === flightId // Kiểm tra theo trường flightId
        );
    }


    function buyTicket(ticketId) {
        // Lấy user_id từ localStorage
        const userId = localStorage.getItem('user_id');

        if (!userId) {
            alert('User ID not found in localStorage. Please log in first.');
            return;
        }
        console.log(ticketId, userId)
        $.ajax({
            url: '/addtickets',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                ticketId: ticketId,
                userId: userId
            }),
            success: function (response) {
                alert('Ticket purchased successfully!');
                location.reload(); // Optional: reload page
            },
            error: function (xhr, status, error) {
                console.error('Error:', error);
                alert('Failed to purchase ticket. Try again later.');
            }
        });

    }







    document.querySelectorAll('.searchLocation').forEach(input => {
        input.addEventListener('input', function () {
            const query = input.value.toLowerCase();
            if (query) {
                const filteredLocations = Array.from(airportCityMap.values()).filter(location =>
                    location.toLowerCase().includes(query)
                );
                showSuggestions(filteredLocations, input);
            }
        });
    });

    function showSuggestions(suggestions, inputElement) {
        const oldSuggestions = inputElement.nextElementSibling;
        if (oldSuggestions) oldSuggestions.remove();

        const suggestionBox = document.createElement('div');
        suggestionBox.classList.add('suggestion-box');
        suggestionBox.style.position = 'absolute';
        suggestionBox.style.width = `${inputElement.offsetWidth}px`;

        suggestions.forEach(suggestion => {
            const suggestionItem = document.createElement('div');
            suggestionItem.classList.add('suggestion-item');
            suggestionItem.textContent = suggestion;
            suggestionBox.appendChild(suggestionItem);

            suggestionItem.addEventListener('click', () => {
                inputElement.value = suggestion;
                suggestionBox.remove();
            });
        });

        inputElement.parentElement.appendChild(suggestionBox);
    }
</script>

</body>
</html>
