<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Hotel List</title>
<script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
<style>
* {
    padding: 0;
    margin: 0;
    box-sizing: border-box;
}

body {
    display: flex;
    flex-direction: column;
    background-color: white;
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
    font-size: 1.3vw;
    color: #fff;
    padding: 10px;
}

.menu {
    display: flex;
    flex-direction: row;
    flex-basis: 40%;
}

.menu ul {
    display: flex;
    flex-direction: row;
    padding: 10px;
}

.menu ul li {
    padding: 10px;
    list-style-type: none;
}

.menu ul li a {
    text-decoration: none;
    padding: 15px;
    font-size: 1.4vw;
    color: #fff;
    font-weight: bold;
}

.menu ul li a:hover {
    color: black;
    background-color: rgb(245, 233, 211);
}



/* Search and Sorting Container */
.sorting {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 30px;
    padding: 10px;
    width: 100%;
    background-color: #f4f4f4;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

/* Search Section */
.search {
    flex-basis: 50%;
}

.search input[type="text"] {
    width: 90%;
    padding: 8px;
    font-size: 16px;
    border: 1px solid #ddd;
    border-radius: 4px;
}

/* Sorting Section */
.search-filter-bar {
    flex-basis: 50%;
    display: flex;
    justify-content: flex-end;
}

.sort-dropdown {
    font-size: 16px;
    padding: 8px;
    border-radius: 4px;
    border: 1px solid #ddd;
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

.star-rating .fas.fa-star, .star-rating .fas.fa-star-half-alt,
    .star-rating .far.fa-star {
    color: gold;
}
.card {
    display: flex;
    flex-direction: row;
    background-color: white;
    border-radius: 8px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    margin-bottom: 20px;
    overflow: hidden;
    position: relative; /* Ensure relative positioning for absolute elements */
}

.card img {
    width: 200px;
    height: 150px;
    object-fit: cover;
}

.card-content {
    padding: 20px;
    width: 100%;
    display: flex;
    justify-content: space-between;
    position: relative; /* Ensure content stays positioned properly */
}

.card-details {
    flex: 2;
}

.card-details h3 {
    font-size: 20px;
    margin-bottom: 10px;
}

.card-details .location,
.card-details .price {
    font-size: 16px;
    color: #666;
}

.card-details .price {
    text-decoration: line-through;
    color: #888;
}

/* Align the 'Book' button to the bottom-right */
.card-actions {
    position: absolute;
    right: 20px;
    bottom: 20px; /* Positions the 'Book' button to the bottom-right corner */
    display: flex;
    flex-direction: column;
    justify-content: flex-end; /* Aligns content to the end */
}

.card-actions .new-price {
    font-size: 22px;
    font-weight: bold;
    color: #333;
}

.card-actions a {
    background-color: #0073e6;
    color: white;
    padding: 10px 20px;
    text-decoration: none;
    border-radius: 5px;
    margin-top: 10px;
    text-align: center; /* Center text within the button */
}

.card-actions a:hover {
    background-color: #005bb5; /* Darken button on hover */
}

       

@media only screen and (max-width: 668px) {
    .main-logo-menu {
        flex-direction: column;
        font-size: 2.4vw;
        align-items: center;
    }
    .menu ul {
        flex-direction: column;
        padding: 10px;
    }
    .card {
        width: calc(100% - 30px); /* Each card takes full width on smaller screens */
    }
    .sorting {
        flex-direction: column;
    }
    .search-filter-bar {
        justify-content: center;
        margin-top: 10px;
    }
}
</style>
<link rel="stylesheet"
    href="https://use.fontawesome.com/releases/v5.3.1/css/all.css"
    integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU"
    crossorigin="anonymous">
</head>
<body>

    <div class="wrapper">
        <div class="main-logo-menu">
            <div class="logo">
                <h2>Hotel Recommendation</h2>
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

        <div class="sorting">
            <!-- Search Bar aligned to the left -->
            <div class="search">
                <form method="get" action="">
                    <input type="text" name="searchQuery" placeholder="Search hotels..."  />
                    
                </form>
            </div>

            <!-- Sorting Dropdown aligned to the right -->
            <div class="search-filter-bar">
                <select class="sort-dropdown">
                    <option value="recommended">Sort by</option>
                    <option value="low-to-high">Price: Low to High</option>
                    <option value="high-to-low">Price: High to Low</option>
                    <option value="guest-rating">Guest Rating</option>
                </select>
            </div>
        </div>

       <!--  <div class="city-container">
            <c:forEach var="h" items="${hlist}">
                <div class="city-card">
                    <img src="<c:url value='/resources/img/${h.image}'/>" alt="${h.hotelName}">
                    <h3>Name : ${h.hotelName}</h3>
                    <p>Contact : ${h.hotelcontact}</p>

                    <c:set var="rating" value="${h.rating}" />
                    <c:set var="fullStars" value="${rating - (rating % 1)}" />
                    <c:set var="halfStar" value="${(rating % 1) >= 0.5 ? 1 : 0}" />
                    <c:set var="emptyStars" value="${5 - fullStars - halfStar}" />

                    <div class="star-rating">
                        <c:forEach var="i" begin="1" end="${fullStars}">
                            <i class="fas fa-star"></i>
                        </c:forEach>
                        <c:if test="${halfStar == 1}">
                            <i class="fas fa-star-half-alt"></i>
                        </c:if>
                        <c:forEach var="i" begin="1" end="${emptyStars}">
                            <i class="far fa-star"></i>
                        </c:forEach>
                    </div>

                    <p>${h.reviews}</p>
                    <a href="${pageContext.request.contextPath}/book?hotelid=${h.hotelid}">Book Hotel</a>
                </div>
            </c:forEach>
        </div> -->

<div class="card-container">
    <c:forEach var="h" items="${hlist}">
        <div class="card">
            <img src="<c:url value='/resources/img/${h.image}'/>" alt="${h.hotelName}">
            <div class="card-content">
                <div class="card-details">
                    <h3>Name: ${h.hotelName}</h3>
                    <p>Contact: ${h.hotelcontact}</p>

                    <c:set var="rating" value="${h.rating}" />
                    <c:set var="fullStars" value="${rating - (rating % 1)}" />
                    <c:set var="halfStar" value="${(rating % 1) >= 0.5 ? 1 : 0}" />
                    <c:set var="emptyStars" value="${5 - fullStars - halfStar}" />

                    <div class="star-rating">
                        <c:forEach var="i" begin="1" end="${fullStars}">
                            <i class="fas fa-star"></i>
                        </c:forEach>
                        <c:if test="${halfStar == 1}">
                            <i class="fas fa-star-half-alt"></i>
                        </c:if>
                        <c:forEach var="i" begin="1" end="${emptyStars}">
                            <i class="far fa-star"></i>
                        </c:forEach>
                    </div>

                    <p> Reviews : ${h.reviews}</p>
                    <p>Price : ${h.price}</p>
                </div>
            </div>
            <div class="card-actions">
                <a href="${pageContext.request.contextPath}/book?hotelid=${h.hotelid}">Book</a>
            </div>
        </div>
    </c:forEach>
</div>


    

        <div class="footer">
            <h3>Contact Us: info@company.com | +123 456 7890</h3>
        </div>
    </div>
<script>
    $(document).ready(function() {
        // Initialize DataTables
        var table = $('#hotelTable').DataTable({
            paging: true,
            searching: true,  // Enables the built-in search bar
            order: [],        // Remove default sorting
        });

        // Custom search input functionality
        $('#hotelSearch').on('keyup', function() {
            table.search(this.value).draw();
        });

        // Custom sorting logic for the dropdown
        $('#sortDropdown').on('change', function() {
            var sortValue = this.value;
            if (sortValue === 'low-to-high') {
                table.order([2, 'asc']).draw(); // Sort by price low to high
            } else if (sortValue === 'high-to-low') {
                table.order([2, 'desc']).draw(); // Sort by price high to low
            } else if (sortValue === 'guest-rating') {
                table.order([3, 'desc']).draw(); // Sort by guest rating
            } else {
                table.order([]).draw(); // Default order
            }
        });
    });
</script>

</body>
</html>
