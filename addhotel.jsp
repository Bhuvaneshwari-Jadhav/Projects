<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Hotel</title>
    <style>
    .card-container.card{
        width:40%;
        margin-top:10px;}
        .error-message {
            color: red;
            font-size: 12px;
            margin-top: 5px;
        }
    </style>
    <link href="<c:url value='/resources/CSS/loginpage.css'/>" rel="stylesheet"/>
    <link rel="stylesheet"
          href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
          integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
          crossorigin="anonymous">
    <link rel="stylesheet"
          href="https://use.fontawesome.com/releases/v5.3.1/css/all.css"
          integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU"
          crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        function validateForm() {
            let isValid = true;

            // Clear previous error messages
            document.querySelectorAll('.error-message').forEach(el => el.textContent = '');

            const hotelName = document.forms["frm"]["hotelName"].value;
            const contact = document.forms["frm"]["hotelcontact"].value;
            const pincode = document.forms["frm"]["pincode"].value;
            const price = document.forms["frm"]["price"].value;
            const rating = document.forms["frm"]["rating"].value;
            const reviews = document.forms["frm"]["reviews"].value;

            // Validate hotelName (no digits allowed)
            if (/\d/.test(hotelName)) {
                document.getElementById('hotelNameError').textContent = "Hotel name should not contain digits.";
                isValid = false;
            }

            // Validate contact (exactly 10 digits)
            if (!/^\d{10}$/.test(contact)) {
                document.getElementById('contactError').textContent = "Contact should be exactly 10 digits.";
                isValid = false;
            }

            // Validate pincode (exactly 6 digits, only digits allowed)
            if (!/^\d{6}$/.test(pincode)) {
                document.getElementById('pincodeError').textContent = "Pincode should be exactly 6 digits.";
                isValid = false;
            }

            // Validate price (only digits allowed)
            if (!/^\d+$/.test(price)) {
                document.getElementById('priceError').textContent = "Price should only contain digits.";
                isValid = false;
            }

            // Validate rating (only digits allowed)
            if (!/^\d+$/.test(rating)) {
                document.getElementById('ratingError').textContent = "Rating should only contain digits.";
                isValid = false;
            }

            // Validate reviews (no digits allowed)
            if (/\d/.test(reviews)) {
                document.getElementById('reviewError').textContent = "Review should not contain digits.";
                isValid = false;
            }

            return isValid;
        }

        $(document).ready(function () {
            // AJAX call to get areas by city ID
            $('select[name="id"]').change(function () {
                const cityId = $(this).val();
                if (cityId) {
                    $.ajax({
                        url: 'getAreasByCity',
                        type: 'GET',
                        data: { id: cityId }, 
                        success: function (areas) {
                            const $areaSelect = $('select[name="aid"]');
                            $areaSelect.empty();
                            $areaSelect.append('<option value="">Select Area</option>');
                            $.each(areas, function (index, area) {
                                $areaSelect.append('<option value="' + area.aid + '">' + area.aname + '</option>');
                            });
                        },
                        error: function () {
                            alert('Failed to retrieve areas. Please try again.');
                        }
                    });
                } else {
                    $('select[name="aid"]').empty().append('<option value="">Select Area</option>');
                }
            });
        });
    </script>
</head>
<body>
    <jsp:include page="adminpro.jsp"></jsp:include>
    <div class="boxx">
        
            <div class="card-container card">
                <h4>Add Hotel</h4>
                <form class="form-signin" name="frm" action="savehotel" method="POST" onsubmit="return validateForm()">
                    <div class="form-group">
                        <select name="id" class="form-control" required>
                            <option value="">Select City</option>
                            <c:forEach var="e" items="${clist}">
                                <option value="${e.id}">${e.cname}</option>
                            </c:forEach>
                        </select>
                        <br>
                        <select name="aid" class="form-control" required>
                            <option value="">Select Area</option>
                        </select>
                        <br>
                        <select name="categoryid" class="form-control" required>
                            <option value="">Select Category</option>
                            <c:forEach var="e" items="${catlist}">
                                <option value="${e.categoryid}">${e.htype}</option>
                            </c:forEach>
                        </select>
                        <br>
                        <input type="text" class="form-control" name="hotelName" placeholder="Enter hotel Name" required="required">
                        <span id="hotelNameError" class="error-message"></span>
                        <input type="text" class="form-control" name="hotelcontact" placeholder="Enter contact" required="required">
                        <span id="contactError" class="error-message"></span>
                        <input type="text" class="form-control" name="hotelAddress" placeholder="Enter Address" required="required">
                        <input type="text" class="form-control" name="pincode" placeholder="Enter pincode" required="required">
                        <span id="pincodeError" class="error-message"></span>
                        <input type="text" class="form-control" name="price" placeholder="Enter price" required="required">
                        <span id="priceError" class="error-message"></span>
                        <input type="text" class="form-control" name="rating" placeholder="Enter rating" required="required">
                        <span id="ratingError" class="error-message"></span>
                        <input type="text" class="form-control" name="reviews" placeholder="Enter reviews" required="required">
                        <span id="reviewError" class="error-message"></span>
                        <input type="text" class="form-control" name="image" placeholder="Enter Image Link" required="required">
                        <br>
                        <button class="btn btn-lg btn-primary btn-block btn-signin" type="submit">Add Hotel</button>
                    </div>
                </form>
                <span style="color:green">${msg}</span>
          
        </div>
    </div>
</body>
</html>
