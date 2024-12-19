<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>User Tickets</title>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Libraries Stylesheet -->
    <link href="${pageContext.request.contextPath}/libs/owlcarousel/assets/owl.carousel.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/libs/lightbox/css/lightbox.min.css" rel="stylesheet">


    <!-- Customized Bootstrap Stylesheet -->
    <link href="${pageContext.request.contextPath}/libs/bootstrap/dist/css/bootstrap.css" rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user/home.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f4f7fc;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1000px;
            margin: 30px auto;
            padding-left: 10px;
            padding-right: 10px;
        }

        h2 {
            font-size: 26px;
            margin: 20px 0;
            text-align: center;
        }

        .responsive-table {
            list-style-type: none;
            padding: 0;
            margin: 0;
        }

        .table-header {
            display: flex;
            background-color: #95A5A6;
            padding: 10px;
            font-size: 14px;
            text-transform: uppercase;
            color: #fff;
            letter-spacing: 0.03em;
        }

        .col {
            flex: 1;
            padding: 10px;
        }

        .table-row {
            background-color: #ffffff;
            box-shadow: 0px 0px 9px rgba(0, 0, 0, 0.1);
            margin-bottom: 10px;
            display: flex;
            padding: 15px;
        }

        .table-row:nth-child(even) {
            background-color: #f9f9f9;
        }

        .table-row .col {
            padding-left: 15px;
            padding-right: 15px;
        }

        .table-row .col:first-child {
            font-weight: bold;
        }

        .delete-btn {
            cursor: pointer;
            color: #e74c3c;
            font-size: 18px;
            font-weight: bold;
            text-align: center;
        }

        /* Modal Styling */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.4);
            overflow: auto;
            padding-top: 60px;
        }

        .modal-content {
            background-color: #fff;
            margin: 5% auto;
            padding: 20px;
            border-radius: 10px;
            width: 80%;
            max-width: 400px;
        }

        .modal-header {
            font-size: 18px;
            margin-bottom: 10px;
        }

        .modal-footer {
            text-align: right;
        }

        .modal-btn {
            padding: 10px 20px;
            font-size: 14px;
            margin: 0 5px;
            cursor: pointer;
            border: none;
            border-radius: 5px;
        }

        .confirm-btn {
            background-color: #e74c3c;
            color: white;
        }

        .cancel-btn {
            background-color: #95a5a6;
            color: white;
        }

        @media all and (max-width: 767px) {
            .table-header {
                display: none;
            }

            .table-row {
                display: block;
            }

            .table-row .col {
                display: block;
                text-align: right;
                padding: 10px;
                font-weight: normal;
                &:before {
                    content: attr(data-label);
                    font-weight: bold;
                    padding-right: 10px;
                    color: #6C7A89;
                    text-align: left;
                    display: inline-block;
                    flex-basis: 50%;
                }
            }
        }
    </style>
</head>
<body>
<%@ include file="../share-view/user-header.jsp" %>
<div class="container">
    <h2>Your Tickets</h2>
    <ul class="responsive-table" id="ticketList">
        <li class="table-header">
            <div class="col">Ticket ID</div>
            <div class="col">Seat Number</div>
            <div class="col">Flight</div>
            <div class="col">Price</div>
            <div class="col">Status</div>
            <div class="col">Actions</div>
        </li>
        <!-- Ticket rows will be added dynamically here -->
    </ul>
</div>

<!-- Modal for confirming delete -->
<div id="deleteModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">Are you sure you want to delete this ticket?</div>
        <div class="modal-footer">
            <button class="modal-btn cancel-btn" id="cancelDeleteBtn">Cancel</button>
            <button class="modal-btn confirm-btn" id="confirmDeleteBtn">Delete</button>
        </div>
    </div>
</div>

<%@ include file="../share-view/user-footer.jsp" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    let ticketToDelete = null;

    function loadUserTickets() {
        const username = localStorage.getItem('username');

        if (!username) {
            alert('User ID not found in localStorage. Please log in first.');
            return;
        }

        $.ajax({
            url: '/api/getAllTickets',
            type: 'GET',
            success: function (tickets) {
                const userTickets = [];

                for (let i = 0; i < tickets.length; i++) {
                    if (tickets[i].userName === username) {
                        userTickets.push(tickets[i]);
                    }
                }

                displayTickets(userTickets);
            },
            error: function (xhr, status, error) {
                console.error('Error:', error);
                alert('Failed to load tickets. Try again later.');
            }
        });
    }

    function displayTickets(tickets) {
        const ticketList = document.getElementById('ticketList');

        if (tickets.length === 0) {
            const noTicketsMessage = document.createElement('li');
            noTicketsMessage.textContent = 'No tickets found for this user.';
            ticketList.appendChild(noTicketsMessage);
            return;
        }

        tickets.forEach(ticket => {
            const ticketRow = document.createElement('li');
            ticketRow.classList.add('table-row');

            ticketRow.innerHTML += '<div class="col" data-label="Ticket ID"> ' + ticket.ticketId + '</div>';
            ticketRow.innerHTML += '<div class="col" data-label="Seat Number"> ' + ticket.seatNumber + '</div>';
            ticketRow.innerHTML += '<div class="col" data-label="Flight"> ' + ticket.flightId + '</div>';
            ticketRow.innerHTML += '<div class="col" data-label="Price"> ' + ticket.finalPrice + '</div>';
            ticketRow.innerHTML += '<div class="col" data-label="Status"> ' + ticket.status + '</div>';
            ticketRow.innerHTML += '<div class="col"><span class="delete-btn" onclick="confirmDelete(' + ticket.ticketId + ')">X</span></div>';
            ticketList.appendChild(ticketRow);

        });
    }

    function confirmDelete(ticketId) {
        ticketToDelete = ticketId;
        const modal = document.getElementById('deleteModal');
        modal.style.display = 'block';
    }

    document.getElementById('cancelDeleteBtn').addEventListener('click', function () {
        const modal = document.getElementById('deleteModal');
        modal.style.display = 'none';
    });

    document.getElementById('confirmDeleteBtn').addEventListener('click', function () {
        if (ticketToDelete) {

            $.ajax({
                url: '/userdeleteticket',
                method: 'POST',
                contentType: 'application/json',

                data: JSON.stringify({
                    ticketId: ticketToDelete
                }),
                success: function(response) {
                    alert('Ticket with ID ' + ticketToDelete + ' deleted.');
                    // Remove ticket from list
                    window.location.href = "/myprofile";
                },
                error: function() {
                    alert('Error occurred while deleting ticket.');
                }
            });

        }
        const modal = document.getElementById('deleteModal');
        modal.style.display = 'none';
    });

    document.addEventListener('DOMContentLoaded', loadUserTickets);
</script>

</body>
</html>
