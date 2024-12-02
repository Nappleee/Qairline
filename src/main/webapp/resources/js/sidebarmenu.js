// ==============================================================
// Auto select left navbar (Vanilla JavaScript)
// ==============================================================
document.addEventListener("DOMContentLoaded", function () {
    "use strict";

    // Lấy URL hiện tại của trang
    var url = window.location.href;

    // Xử lý URL để lấy path sau domain
    var path = url.replace(
        window.location.protocol + "//" + window.location.host + "/",
        ""
    );

    // Tìm các thẻ <a> trong #sidebarnav
    var links = document.querySelectorAll("ul#sidebarnav a");
    var activeElement = null;

    links.forEach(function (link) {
        if (link.href === url || link.href === path) {
            activeElement = link;
        }
    });
    console.log(activeElement);
    if (activeElement) {
        // Thêm class "active" vào <a> đang khớp
        activeElement.classList.add("active");

        // Thêm class "active" và "selected" vào cha của <a>
        var parent = activeElement.parentElement;
        while (parent && !parent.classList.contains("sidebar-nav")) {
            if (parent.tagName === "LI") {
                parent.classList.add("selected");
                var parentLink = parent.querySelector("a");
                if (parentLink) {
                    parentLink.classList.add("active");
                }
            }
            if (parent.tagName === "UL") {
                parent.classList.add("in");
            }
            parent = parent.parentElement;
        }
    }

    // Xử lý sự kiện click cho các link
    document.querySelectorAll("#sidebarnav a").forEach(function (link) {
        link.addEventListener("click", function (e) {
            var nextUl = link.nextElementSibling;
            console.log(link)

            if (!link.classList.contains("active")) {
                // Ẩn các menu đang mở
                document.querySelectorAll("ul.in").forEach(function (ul) {
                    ul.classList.remove("in");
                });

                // Loại bỏ class "active"
                document.querySelectorAll("#sidebarnav a.active").forEach(function (a) {
                    a.classList.remove("active");
                });

                // Thêm class "active" và mở menu mới
                link.classList.add("active");
                if (nextUl && nextUl.tagName === "UL") {
                    nextUl.classList.add("in");
                }
            } else {
                // Nếu đã "active", loại bỏ class "active" và đóng menu
                link.classList.remove("active");
                if (nextUl && nextUl.tagName === "UL") {
                    nextUl.classList.remove("in");
                }
            }
        });
    });

    // Chặn sự kiện mặc định với các link có class "has-arrow"
    document.querySelectorAll("#sidebarnav > li > a.has-arrow").forEach(function (link) {
        link.addEventListener("click", function (e) {
            e.preventDefault();
        });
    });
});
