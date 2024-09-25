<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

h1
{
padding-top:50px;}

</style>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
<link href="<c:url value="/resources/CSS/adminpro.css"/>" rel="stylesheet" />
<link href="<c:url value="/resources/CSS/loginpage.css"/>" rel="stylesheet" />
</head>
<body>

	<div class="sidenav">
		<div class="admin">
			<img id="profile-img" class="profile-img-card"
				src="//ssl.gstatic.com/accounts/ui/avatar_2x.png"
				
				
				
				alt="not found">
			<h3>Admin Profile</h3>
		</div>
		<button class="dropdown-btn">
			Cities <i class="fa fa-caret-down"></i>
		</button>
		<div class="dropdown-container">
			<a href="city">Add New City</a> 
			<a href="viewcitylist">View All Cities</a> 
		
		</div>
		<button class="dropdown-btn">
			Areas <i class="fa fa-caret-down"></i>
		</button>
		<div class="dropdown-container">
			<a href="area">Add Areas</a> 
			<a href="viewareabycity">View Areas</a> 
		</div>
		<button class="dropdown-btn">
			Hotels <i class="fa fa-caret-down"></i>
		</button>
		<div class="dropdown-container">
			<a href="category">Hotel Categories </a>
			<a href="viewcat">View Categories </a>
			<a href="addhotel">Add new Hotels</a> 
			<a href="viewhotel">View Hotels</a> 
		</div>
		
	</div>


	<script>
		/* Loop through all dropdown buttons to toggle between hiding and showing its dropdown content - This allows the user to have multiple dropdowns without any conflict */
		var dropdown = document.getElementsByClassName("dropdown-btn");
		var i;

		for (i = 0; i < dropdown.length; i++) {
			dropdown[i].addEventListener("click", function() {
				this.classList.toggle("active");
				var dropdownContent = this.nextElementSibling;
				if (dropdownContent.style.display === "block") {
					dropdownContent.style.display = "none";
				} else {
					dropdownContent.style.display = "block";
				}
			});
		}
	</script>

</body>
</html>