// Airport City Map for Suggestions
let airportCityMap = new Map([
    ['SGN', 'Ho Chi Minh City'],
    ['HAN', 'Hanoi'],
    ['JFK', 'New York'],
    ['LHR', 'London'],
    ['DXB', 'Dubai']
]);

// Customer data model
var customer = {
    typeOfFlight: "One-way",
    departure: "",
    destination: "",
    departure_time: "",
    returnDate: "",
    passengers: 1,
    promoCode: ""
};

// Fetch and render available flights
function findingAirplane() {
    gettingCustomerRequest(); // Collect customer data from inputs
    console.log("Customer search:", customer);
    const url = '/api/getAllFlights'
    //const url = `/api/flightsSearch?keyword=${customer.departure}&destination=${customer.destination}&departure_time=${customer.departure_time}`;
    fetch(url, {
        method: 'GET',
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('accessToken')
        }
    })
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to fetch flights');
            }
            return response.json();
        })
        .then(data => {
            console.log("Flights Data:", data);
            displayFlights(data.content); // Render flights in modal
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Could not fetch flights. Please try again later.');
        });
}

// Collect customer data from form inputs
function gettingCustomerRequest() {
    customer.departure = airportCityMap.get(document.getElementById("departure").value) || document.getElementById("departure").value;
    customer.destination = airportCityMap.get(document.getElementById("destination").value) || document.getElementById("destination").value;
    customer.departure_time = document.getElementById("departure_time").value;
    customer.returnDate = document.getElementById("returnDate").value;
    customer.passengers = document.getElementById("passengers").value;
    customer.promoCode = document.getElementById("promoCode").value;
}

// Render flights in the modal
function displayFlights(flights) {
    const flightsList = document.getElementById('flightsList');
    flightsList.innerHTML = ''; // Clear old results

    if (flights.length === 0) {
        flightsList.innerHTML = `<p>No flights found matching your criteria.</p>`;
        return;
    }

    flights.forEach(flight => {
        const flightHTML = `
            <div class="border p-3 rounded position-relative mb-2">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h6>Flight ID: ${flight.flightId}</h6>
                        <p>${flight.departure} → ${flight.destination}</p>
                        <p>Departure: ${new Date(flight.departureTime).toLocaleString()}</p>
                        <p>Price: ${flight.ticketPrice.toLocaleString()} VND</p>
                    </div>
                    <button class="btn btn-primary">Book</button>
                </div>
            </div>`;
        flightsList.innerHTML += flightHTML;
    });
}

// Show autocomplete suggestions
function showSuggestions(suggestions, inputElement) {
    // Remove old suggestions
    const oldSuggestions = inputElement.nextElementSibling;
    if (oldSuggestions) oldSuggestions.remove();

    // Create new suggestion box
    const suggestionBox = document.createElement('div');
    suggestionBox.classList.add('suggestion-box');
    suggestionBox.style.position = 'absolute';
    suggestionBox.style.width = `${inputElement.offsetWidth}px`;
    suggestionBox.style.zIndex = '10';

    suggestions.forEach(suggestion => {
        const suggestionItem = document.createElement('div');
        suggestionItem.classList.add('suggestion-item');
        suggestionItem.textContent = suggestion;
        suggestionBox.appendChild(suggestionItem);

        suggestionItem.addEventListener('click', () => {
            inputElement.value = suggestion; // Set selected value
            suggestionBox.remove(); // Remove suggestions
        });
    });

    // Append suggestion box to input's parent
    inputElement.parentElement.appendChild(suggestionBox);

    // Close suggestions if clicked outside
    document.addEventListener('click', function (event) {
        if (!inputElement.contains(event.target) && !suggestionBox.contains(event.target)) {
            suggestionBox.remove();
        }
    }, { once: true });
}

// Attach suggestion logic to inputs
const inputs = document.getElementsByClassName('searchLocation');
Array.from(inputs).forEach(input => {
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
