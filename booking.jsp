<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hotel Booking Form</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f0f3f7;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }
    .wrapper {
        display: flex;
        flex-direction: column;
        width: 94%;
        min-height: 200px;
        background-color: white;
        margin: auto;
    }

    .main-logo-menu {
        display: flex;
        flex-direction: row;
        width: 100%;
        min-height: 50px;
        background-color: #3A1078;
    }

    .logo {
        display: flex;
        flex-basis: 60%;
        font-size: 1vw;
        color: #fff;
        padding: 5px;
    }

    .menu {
        display: flex;
        flex-direction: row;
        flex-basis: 40%;
    }

    .menu ul {
        display: flex;
        flex-direction: row;
        padding: 5px;
    }

    .menu ul li {
        padding: 5px;
        list-style-type: none;
    }

    .menu ul li a {
        text-decoration: none;
        padding: 5px;
        font-size: 1.4vw;
        color: #fff;
        font-weight: bold;
    }

    .menu ul li a:hover {
        color: black;
        background-color: rgb(245, 233, 211);
    }

    .content-wrapper {
        display: flex;
        justify-content: space-between;
        width: 100%;
        margin-top: 10px;
    }

    .form-container {
        width: 45%;
        background: rgba(255, 255, 255, 0.9);
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        background-color:  #F5F5F5;
    }

    .form-container h1, .review-container h1 {
        margin-bottom: 20px;
        font-size: 24px;
    }

    .form-container input[type="text"], 
    .form-container input[type="date"], 
    .form-container input[type="tel"] ,
    .form-container input[type="number"]{
        width: calc(40% - 10px);
        padding: 10px;
        margin: 5px;
        margin-bottom: 20px;
        border: 1px solid #ddd;
        border-radius: 5px;
    }

    .form-container input[type="submit"] {
        background-color: green;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
    }

    .form-container input[type="submit"]:hover {
        background-color: darkgreen;
    }

    .loading-message {
        display: none;
        margin-top: 20px;
        font-size: 18px;
        color: #007bff;
    }

    .footer {
        display: flex;
        width: 100%;
        height: 60px;
        font-size: 1.5vw;
        background-color: #3A1078;
        color: white;
        justify-content: center;
        align-items: center;
        margin-top: 10px;
    }

    /* Modal styles */
    .modal {
        display: none;
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0,0,0,0.5);
    }

    .modal-content {
        background-color: #fefefe;
        margin: 15% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 50%;
        border-radius: 10px;
    }

    .close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }

    .close:hover, .close:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
    }

    .star-rating {
        font-size: 24px;
        direction: rtl;
        display: flex;
        justify-content: center;
    }

    .star-rating input {
        display: none;
    }

    .star-rating label {
        color: grey;
        font-size: 40px;
        padding: 0 10px;
        cursor: pointer;
    }

    .star-rating input:checked ~ label,
    .star-rating label:hover,
    .star-rating label:hover ~ label {
        color: gold;
    }
    .review-button-container
    {
    padding:20px;
    boder:1px solid grey;}
.review-button {
    width: 300px;
    padding: 15px;
    background-color: #ff6600; /* Vibrant orange */
    color: white;
    margin-right:20px;
    font-size: 18px;
    font-weight: bold;
    border: none;
    border-radius: 30px;
    cursor: pointer;
    box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
    transition: all 0.3s ease;
}

.review-button:hover {
    background-color: #ff4500; /* Darker shade on hover */
    box-shadow: 0 15px 25px rgba(0, 0, 0, 0.2);
    transform: translateY(-3px);
}

.review-button:active {
    transform: translateY(1px); /* Slight press-down effect */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

    .review-container textarea {
        width: calc(100% - 30px);
        height: 100px;
        padding: 10px;
        margin-top: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
        resize: none;
    }
</style>
<script>
function validateForm() {
    var name = document.forms["bookingForm"]["FirstName"].value;
    var email = document.forms["bookingForm"]["email"].value;
    var contact = document.forms["bookingForm"]["contact"].value;
    var guests = document.forms["bookingForm"]["guests"].value;
    var checkinDate = new Date(document.forms["bookingForm"]["checkinDate"].value);
    var checkoutDate = new Date(document.forms["bookingForm"]["checkoutDate"].value);
    var today = new Date();

    var namePattern = /^[A-Za-z\s]+$/;
    var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    var contactPattern = /^[0-9]{10}$/;

    // Validate Name (No digits)
    if (!namePattern.test(name)) {
        alert("Name must not contain digits or special characters.");
        return false;
    }

    // Validate Email
    if (!emailPattern.test(email)) {
        alert("Please enter a valid email address.");
        return false;
    }

    // Validate Contact (Exactly 10 digits)
    if (!contactPattern.test(contact)) {
        alert("Contact must be exactly 10 digits.");
        return false;
    }

    // Validate Guests (Less than or equal to 5)
    if (isNaN(guests) || guests < 1 || guests > 5) {
        alert("Guests must be between 1 and 5.");
        return false;
    }

    // Validate Check-in/Check-out dates (Future dates)
    if (checkinDate < today || checkoutDate <= checkinDate) {
        alert("Check-in date must be after today, and check-out date must be after check-in.");
        return false;
    }

    return true;
}

function showReviewModal() {
    var modal = document.getElementById("reviewModal");
    modal.style.display = "block";
}

function closeReviewModal() {
    var modal = document.getElementById("reviewModal");
    modal.style.display = "none";
}

function askForReview() {
    if (confirm("Do you want to give a review?")) {
        showReviewModal();
    } 
}
</script>
</head>
<body>

<div class="wrapper">
    <div class="main-logo-menu">
        <div class="logo">
            <h2>Make my trip</h2>
        </div>
        <div class="menu">
            <ul>
                <li><a href="#">Home</a></li>
                <li><a href="#" class="submit">Register</a></li>
                <li><a href="ad" class="submit">Login</a></li>
                <li><a href="<c:url value='/logout' />" class="btn btn-outline-danger">Logout</a></li>
            </ul>
        </div>
    </div>

    <div class="content-wrapper">
        <!-- Form Container -->
        <div class="form-container">
            <h1>User Registration</h1>
            <h3>Please fill in your details to book a hotel</h3>
            <form name="bookingForm" action="infosave" method="post" onsubmit="return validateForm()">
                <input type="text" name="FirstName" placeholder="Enter Name" required>
                <input type="text" name="email" placeholder="Email" required><br>
                <input type="tel" name="contact" placeholder="Contact (10 digits)" required pattern="[0-9]{10}"><br>

                <h3>Booking Information</h3>
                <input type="date" name="checkinDate" placeholder="MM-DD-YYYY" required>
                <input type="date" name="checkoutDate" placeholder="MM-DD-YYYY" required><br>
                <input type="number" name="guests" placeholder="Number of Guests (Max 5)" required min="1" max="5">

                <input type="submit" value="Submit"><br>
                <span style="color:green">${msg}</span>
            </form>
        </div>

        <!-- Review Button -->
        <div class="review-button-container">
        
        
          <div> <p>A very good day, [customer name].</p>
     <p>We confirm that you have a reservation at [ hotel name] from the [insert checkin date] to [insert checkout date].</p> 
     
    <p> For more information about your booking, please visit [link to reservation].</p>
    <br>
</div>
    <button onclick="askForReview()" class="review-button">Do you want to give a review?</button><br></br>
    
  
    
   </div>

        <!-- Modal for Review -->
        <div id="reviewModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeReviewModal()">&times;</span>
                <h1>Rate & Review</h1>
                <div class="star-rating">
                    <input type="radio" name="rating" id="5-stars" value="5"><label for="5-stars">★</label>
                    <input type="radio" name="rating" id="4-stars" value="4"><label for="4-stars">★</label>
                    <input type="radio" name="rating" id="3-stars" value="3"><label for="3-stars">★</label>
                    <input type="radio" name="rating" id="2-stars" value="2"><label for="2-stars">★</label>
                    <input type="radio" name="rating" id="1-star" value="1"><label for="1-star">★</label>
                </div>
                <textarea name="review" placeholder="Write your review here..." required></textarea>
                <br>
                <input type="submit" value="Submit Review">
            </div>
        </div>
    </div>

    <div class="footer">
        <h3>Contact Us: info@company.com | +123 456 7890</h3>
    </div>
</div>

</body>
</html>
