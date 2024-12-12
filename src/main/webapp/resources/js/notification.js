(function ($) {
    "use strict";

    const notificationBell = document.getElementById("NotificationBell");

    // Spinner
    var spinner = function () {
        setTimeout(function () {
            if ($('#spinner').length > 0) {
                $('#spinner').removeClass('show');
            }
        }, 1);
    };
    spinner(0);


    // Sticky Navbar
    $(window).scroll(function () {
        if ($(this).scrollTop() > 45) {
            $('.navbar').addClass('sticky-top shadow-sm');
        } else {
            $('.navbar').removeClass('sticky-top shadow-sm');
        }
    });




    // International Tour carousel
    $(".InternationalTour-carousel").owlCarousel({
        autoplay: true,
        smartSpeed: 1000,
        center: false,
        dots: true,
        loop: true,
        margin: 25,
        nav : false,
        navText : [
            '<i class="bi bi-arrow-left"></i>',
            '<i class="bi bi-arrow-right"></i>'
        ],
        responsiveClass: true,
        responsive: {
            0:{
                items:1
            },
            768:{
                items:2
            },
            992:{
                items:2
            },
            1200:{
                items:3
            }
        }
    });


    // packages carousel
    $(".packages-carousel").owlCarousel({
        autoplay: true,
        smartSpeed: 1000,
        center: false,
        dots: false,
        loop: true,
        margin: 25,
        nav : true,
        navText : [
            '<i class="bi bi-arrow-left"></i>',
            '<i class="bi bi-arrow-right"></i>'
        ],
        responsiveClass: true,
        responsive: {
            0:{
                items:1
            },
            768:{
                items:2
            },
            992:{
                items:2
            },
            1200:{
                items:3
            }
        }
    });


    // testimonial carousel
    $(".testimonial-carousel").owlCarousel({
        autoplay: true,
        smartSpeed: 1000,
        center: true,
        dots: true,
        loop: true,
        margin: 25,
        nav : true,
        navText : [
            '<i class="bi bi-arrow-left"></i>',
            '<i class="bi bi-arrow-right"></i>'
        ],
        responsiveClass: true,
        responsive: {
            0:{
                items:1
            },
            768:{
                items:2
            },
            992:{
                items:2
            },
            1200:{
                items:3
            }
        }
    });


    // Back to top button
    $(window).scroll(function () {
        if ($(this).scrollTop() > 300) {
            $('.back-to-top').fadeIn('slow');
        } else {
            $('.back-to-top').fadeOut('slow');
        }
    });
    $('.back-to-top').click(function () {
        $('html, body').animate({scrollTop: 0}, 1500, 'easeInOutExpo');
        return false;
    });

})(jQuery);
let airportCityMap = new Map([
    ['SGN', 'Ho Chi Minh City'],  // Mã sân bay SGN -> Thành phố Hồ Chí Minh
    ['HAN', 'Hanoi'],             // Mã sân bay HAN -> Hà Nội
    ['JFK', 'New York'],         // Mã sân bay JFK -> New York
    ['LHR', 'London'],           // Mã sân bay LHR -> London
    ['DXB', 'Dubai']             // Mã sân bay DXB -> Dubai
]);

var customer = {
    typeOfFlight: "One-way", // Hoặc "Round-trip"
    departure: "Hanoi",    // Địa điểm khởi hành
    destination: "Ho Chi Minh City", // Địa điểm đến
    departure_time: "2024-12-10", // Ngày khởi hành (theo định dạng YYYY-MM-DD)
    returnDate: "2024-12-20", // Ngày trở về (nếu có)
    passengers: 2, // Số lượng hành khách
    promoCode: "DISCOUNT20" // Mã giảm giá (nếu có)
};

function gettingCustomerRequest() {
    customer.departure = airportCityMap.get(document.getElementById("departure").value);
    customer.destination = airportCityMap.get(document.getElementById("destination").value);
    customer.departure_time = document.getElementById("departure_time").value;
    customer.returnDate = document.getElementById("returnDate").value;
    customer.passengers = document.getElementById("passengers").value
}

// Bắt sự kiện nút "Tìm chuyến bay"
function findingAirplane() {
    gettingCustomerRequest();
    console.log("D");
    // Dữ liệu mẫu: chuyến bay
    var availableFlight = [
        {
            airline: "Vietnam Airlines",
            departure: "Hanoi",    // Địa điểm khởi hành
            destination: "Ho Chi Minh City", // Địa điểm đến
            departure_time: "2024-12-10",
            ticket_price: "2,500,000",
            flight_id: 'flight1',
            departure_hour: '1.00 PM',
        },
        {
            airline: "Bamboo Airways",
            departure: "Hanoi",    // Địa điểm khởi hành
            destination: "Bangkok", // Địa điểm đến
            departure_time: "2024-12-15",
            ticket_price: '2,200,000',
            flight_id: 'flight2',
            departure_hour: '1.00 PM',
        },
    ]
    var flights = [];
    for (let i = 0; i < availableFlight.length; i++) {
        let flight = availableFlight[i];
        console.log(customer.departure_time === flight.day, customer.departure_time, flight.day)
        if(customer.departure == flight.departure && customer.destination == flight.destination){
            flights.push(flight)
        }
    }


    searchContainer = document.getElementById("searchContainer")




    // Hiển thị các chuyến bay trong modal
    const flightsList = document.getElementById('flightsList');
    flightsList.innerHTML = ''; // Xóa nội dung cũ
    flights.forEach(flight => {
        const flightHTML = `
            <div class="border p-3 rounded position-relative">
                <div class="d-flex justify-content-between align-items-center">
                    <!-- Thông tin chuyến bay -->
                    <div>
                        <h6 class="mb-1">Hãng: ${flight.airline}</h6>
                        <p class="mb-1">Giờ khởi hành: ${flight.departure_hour}</p>
                        <p class="mb-1">Giá: ${flight.ticket_price} VND</p>
                    </div>
                    <!-- Nút mũi tên -->
                    <div>
                        <button class="btn btn-sm btn-light toggle-details" data-target="#details-${flight.flight_id}">
                            ▼
                        </button>
                    </div>
                    <!-- Nút chọn chuyến bay -->
                    <div>
                        <input type="checkbox" id="${flight.flight_id}" class="form-check-input flight-select" data-toggle="collapse" data-target="#${flight.id}-options">
                        <label for="${flight.flight_id}" class="form-check-label">Chọn</label>
                    </div>
                </div>
                <!-- Thông tin chi tiết -->
            <div id="details-${flight.flight_id}" class="mt-3 collapse detailsFlight">
                <h6>Hạng vé:</h6>
                <div class = "container">
                    <div class="row">
                        <div class="col-6 Economy">
                            <h5>Economy</h5>
                            <ul>
                                <li><strong>Hạng thường:</strong> Không bao gồm hành lý, không hoàn vé.</li>
                                <li><strong>Thương gia:</strong> Bao gồm hành lý, ghế ngồi rộng rãi, ưu tiên check-in.</li>
                            </ul>
                            <p><strong>Tiện ích:</strong> Wifi miễn phí, đồ uống miễn phí, dịch vụ giải trí.</p>
                        </div>
                        <div class="col-6 Business">
                            <h5>Business</h5>
                            <ul>
                                <li><strong>Hạng thường:</strong> Không bao gồm hành lý, không hoàn vé.</li>
                                <li><strong>Thương gia:</strong> Bao gồm hành lý, ghế ngồi rộng rãi, ưu tiên check-in.</li>
                            </ul>
                            <p><strong>Tiện ích:</strong> Wifi miễn phí, đồ uống miễn phí, dịch vụ giải trí.</p>
                        </div>
                    </div>
                </div>
            </div>
            `;
        flightsList.innerHTML += flightHTML;
    });
    // Gắn sự kiện cho nút mũi tên (mở rộng và thu gọn)
    document.querySelectorAll('.toggle-details').forEach(button => {
        button.addEventListener('click', function () {
            const target = document.querySelector(button.getAttribute('data-target'));
            if (target.classList.contains('collapse')) {
                target.classList.remove('collapse'); // Mở rộng
                button.innerText = '▲';
            } else {
                target.classList.add('collapse'); // Thu gọn
                button.innerText = '▼';
            }
        });
    });

    const flightOptions = document.querySelectorAll('.detailsFlight .col-6');
    console.log(flightOptions)
    flightOptions.forEach(option => {
        option.addEventListener('click', function () {
            console.log("D");
            // Loại bỏ lớp 'selected' khỏi tất cả các ô
            flightOptions.forEach(opt => opt.classList.remove('selected'));
            // Thêm lớp 'selected' cho ô được nhấp
            this.classList.add('selected');
        });
    });


    // Hiển thị modal
    const modal = new bootstrap.Modal(document.getElementById('flightModal'));
    modal.show();



}


function checkedForm(selectedInput) {
    // Lấy tất cả các phần tử .form-check
    console.log("DDD");
    const formChecks = document.querySelectorAll('.form-check');

    // Loại bỏ class "active" khỏi tất cả các form-check
    formChecks.forEach(formCheck => formCheck.classList.remove('active'));

    // Thêm class "active" cho form-check chứa input được chọn
    selectedInput.closest('.form-check').classList.add('active');

    // Lấy giá trị của input được chọn
    const selectedValue = selectedInput.value;
    customer.typeOfFlight = selectedInput.value;
    console.log("Selected Value:", selectedValue);
}







const locations = [
    "Hà Nội (HAN), Việt Nam",
    "TP. Hồ Chí Minh (SGN), Việt Nam",
    "Đà Nẵng (DAD), Việt Nam",
    "Cần Thơ (VCA), Việt Nam",
    "Bangkok (BKK), Thái Lan",
    "Singapore (SIN), Singapore",
    "Kuala Lumpur (KUL), Malaysia"
];

// Tạo dropdown gợi ý khi người dùng nhập
// Lấy tất cả các input có class 'searchLocation'
const inputs = document.getElementsByClassName('searchLocation');

// Duyệt qua tất cả các phần tử và thêm sự kiện 'input'
for (let i = 0; i < inputs.length; i++) {
    inputs[i].addEventListener('input', function() {
        const query = inputs[i].value;
        if (query) {
            // Giả sử bạn có một mảng tên thành phố để tìm kiếm
            const filteredLocations = locations.filter(location => location.toLowerCase().includes(query.toLowerCase()));

            // Hiển thị kết quả gợi ý
            showSuggestions(filteredLocations, inputs[i]);
        }
    });
}

function showSuggestions(suggestions, inputElement) {
    // Xóa danh sách gợi ý cũ
    const oldSuggestions = inputElement.nextElementSibling;
    if (oldSuggestions) oldSuggestions.remove();

    // Tạo một div mới để hiển thị các gợi ý
    const suggestionBox = document.createElement('div');
    suggestionBox.classList.add('suggestion-box');
    suggestionBox.style.position = 'absolute';
    suggestionBox.style.width = inputElement.offsetWidth + 'px'; // Đảm bảo box gợi ý bằng với độ rộng của input
    suggestionBox.style.zIndex = '10'; // Đảm bảo gợi ý hiển thị trên các phần tử khác

    // Thêm các gợi ý vào box
    suggestions.forEach(suggestion => {
        const suggestionItem = document.createElement('div');
        suggestionItem.classList.add('suggestion-item');
        suggestionItem.textContent = suggestion;
        suggestionBox.appendChild(suggestionItem);

        // Khi người dùng chọn một gợi ý
        suggestionItem.addEventListener('click', function() {
            inputElement.value = suggestion;  // Điền gợi ý vào input
            suggestionBox.remove();  // Xóa box gợi ý
        });
    });

    // Đặt box gợi ý ngay dưới input
    inputElement.parentElement.appendChild(suggestionBox);

    // Thêm sự kiện để đóng gợi ý khi click ra ngoài
    document.addEventListener('click', function(event) {
        if (!inputElement.contains(event.target) && !suggestionBox.contains(event.target)) {
            suggestionBox.remove();  // Đóng hộp gợi ý nếu click ra ngoài
        }
    }, { once: true }); // Đảm bảo sự kiện chỉ được xử lý một lần khi gợi ý hiển thị
}
