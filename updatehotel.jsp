<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.card-container .card
        {
        margin-top:100px;}

</style>
</head>
<body>
<jsp:include page="adminpro.jsp"></jsp:include>
    <div class="boxx">
        <div class="card-container card">
            
                <h3>Add Hotel</h3>
                <form class="form-signin" name="frm" action="saveupdatedhotel" method="POST">
                    <div class="form-group">
                    <input type="hidden" class="form-control" name="hotelid" >
                        
                        <input type="text" class="form-control" name="hotelName" placeholder="Enter hotel Name" required="required">
                        <span id="hotelNameError" class="error-message"></span>
                        <input type="text" class="form-control" name="contact" placeholder="Enter contact" required="required">
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
                        <input type="text" class="form-control" name="image" placeholder="Enter image link" required="required">
                        <br>
                        <button class="btn btn-lg btn-primary btn-block btn-signin" type="submit">Add Hotel</button>
                    </div>
                </form>
                <span style="color:green">${msg}</span>
            </div>
       
    </div>
</body>
</html>