<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />
    <title>Hotel Recommendations</title>

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
            width: 94%;
            margin: auto;
            background-color: white;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            background-color: #4E31AA;
            padding: 20px;
        }

        .navbar .logo h2 {
            color: white;
            font-size: 1.8vw;
        }

        .navbar .menu ul {
            display: flex;
            list-style: none;
        }

        .navbar .menu ul li {
            margin-left: 20px;
        }

        .navbar .menu ul li a {
            text-decoration: none;
            color: white;
            font-size: 1.2vw;
            font-weight: bold;
            padding: 10px;
        }

        .navbar .menu ul li a:hover {
            background-color: #f5e9d3;
            color: black;
        }

        .banner img {
            width: 100%;
            height: 500px;
        }

        .text-on-image {
            position: absolute;
            top: 40%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 3vw;
            font-weight: bold;
            color: white;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.7);
        }
    
        .scroll-container {
            display: flex;
            overflow-x: auto;
            gap: 20px;
            padding: 20px;
        }

        .city-card {
            background-color: blue;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            padding: 10px;
            border-radius: 8px;
            flex: 0 0 auto;
            width: 200px;
        }

        .city-card a {
            text-decoration: none;
            color: white;
        }
         .hotel-grid-container {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        gap: 20px;
        margin: 20px;
    }

    .hotel-card {
        border: 1px solid #ddd;
        border-radius: 10px;
        overflow: hidden;
        background-color: #fff;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .hotel-image img {
        width: 100%;
        height: 200px;
        object-fit: cover;
    }

    .hotel-content {
        padding: 20px;
    }

    .hotel-content h3 {
        font-size: 1.5rem;
        margin-bottom: 10px;
        color: #333;
    }

    .hotel-content p {
        font-size: 1rem;
        color: #666;
        margin-bottom: 10px;
    }

    .hotel-rating {
        margin-bottom: 10px;
    }

    .star-rating {
        display: inline-block;
        color: #ff9800;
        font-size: 1.2rem;
    }

    .hotel-actions {
        text-align: center;
        margin-top: 15px;
    }

    .book-btn {
        background-color: #007bff;
        color: #fff;
        padding: 10px 20px;
        text-decoration: none;
        border-radius: 5px;
    }
     .container {
            width: 95%;
            margin: auto;
            padding-top: 20px;
        }

        .heading {
            text-align: center;
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 30px;
        }

        .grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            grid-template-rows: auto;
            grid-gap: 20px;
        }

        .grid-item {
            position: relative;
            overflow: hidden;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .grid-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .grid-item h2 {
            position: absolute;
            bottom: 10px;
            left: 10px;
            color: white;
            font-size: 1.5rem;
            background-color: rgba(0, 0, 0, 0.5);
            padding: 10px;
            border-radius: 5px;
        }

        .grid-item.villas h2 {
            background-color: rgba(255, 215, 0, 0.8);
            color: black;
        }

        .grid-item.campsites h2 {
            background-color: rgba(144, 238, 144, 0.8);
            color: darkgreen;
        }

    .book-btn:hover {
        background-color: #0056b3;
    }
     .footer {
            background-color: #3A1078;
            color: white;
            text-align: center;
            padding: 20px;
            margin-top: 20px;
        }

    
     @media only screen and (max-width: 768px) {
     
     .navbar {
                flex-direction: column;
                align-items: center;
            }

            .navbar .logo h2 {
                font-size: 5vw;
            }

            .banner img {
                height: auto;
            }

            .navbar .menu ul {
                flex-direction: column;
            }

            .navbar .menu ul li a {
                font-size: 3vw;
            }

            .city-card h3 {
                font-size: 3vw;
            }

            .text-on-image {
                font-size: 5vw;
            }
     
        .hotel-content {
            padding: 15px;
        }
         .grid {
        grid-template-columns: 1fr; /* 1 column on small screens */
    }

    .grid-item h2 {
        font-size: 1rem; /* Adjust text size for small screens */
    }
    }
    </style>
</head>
<body>
    <div class="wrapper">
        <div class="navbar">
            <div class="logo">
                <h2>Make My Trip</h2>
            </div>
            <div class="menu">
                <ul>
                    <li><a href="#">Home</a></li>
                    <li><a href="#">Register</a></li>
                    <li><a href="ad">Login</a></li>
                </ul>
            </div>
        </div>

 <!-- Banner Section -->
        <div class="banner">
            <img src="<c:url value='/resources/img/royal-sonesta.jpg' />" alt="Hotel Image">
            <div class="text-on-image">
                <h3>Hotel Recommendation System</h3>
            </div>
        </div>
        
        <!-- City List Section -->
        <h1 style="text-align:center; margin-top: 20px;">Cities List</h1>
        <form method="get" action="${pageContext.request.contextPath}/">
            <div class="scroll-container">
                <c:forEach var="e" items="${clist}">
                    <div class="city-card">
                        <a href="${pageContext.request.contextPath}/?id=${e.id}">
                            ${e.cname}
                        </a>
                    </div>
                </c:forEach>
            </div>

            <!-- Area List Section -->
            <c:if test="${not empty alist}">
                <h1 style="text-align:center; margin-top: 20px;">Areas List</h1>
                <div class="scroll-container">
                    <c:forEach var="a" items="${alist}">
                        <div class="city-card">
                            <a href="${pageContext.request.contextPath}/?id=${param.id}&aid=${a.aid}">
                                ${a.aname}
                            </a>
                        </div>
                    </c:forEach>
                </div>
            </c:if>

            <!-- Hotel List Section -->
           <!-- Hotel List Section -->
<h1 style="text-align:center; margin-top: 20px;">Hotels List</h1>
<div class="hotel-grid-container">
    <c:forEach var="h" items="${hlist}">
        <div class="hotel-card">
            <div class="hotel-image">
                <img src="<c:url value='/resources/img/${h.image}' />" alt="${h.hotelName}">
            </div>
            <div class="hotel-content">
                <h3>${h.hotelName}</h3>
                <p><strong>Contact:</strong> ${h.hotelcontact}</p>
                
                <!-- Star Rating -->
                <div class="hotel-rating">
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
                </div>

                <p><strong>Reviews:</strong> ${h.reviews}</p>
                <p><strong>Price:</strong> $${h.price}</p>

                <div class="hotel-actions">
                    <a href="${pageContext.request.contextPath}/book?hotelid=${h.hotelid}" class="book-btn">Book Now</a>
                </div>
            </div>
        </div>
    </c:forEach>
</div>
        </form>



 <!-- Vacation Rentals Section -->
        <div class="container">
            <div class="heading">Vacation rentals for every kind of trip</div>
            <div class="grid">
                <div class="grid-item">
                    <img src="<c:url value='/resources/img/bangalows.jpg'/>" alt="Bungalows">
                    <h2>Bungalows</h2>
                </div>
                <div class="grid-item villas">
                    <img src="<c:url value='/resources/img/villas1.jpg'/>" alt="Villas">
                    <h2>Villas</h2>
                </div>
                <div class="grid-item campsites">
                    <img src="<c:url value='/resources/img/boats.jfif'/>" alt="Campsites & Boats">
                    <h2>Campsites & Boats</h2>
                </div>
                <div class="grid-item">
                    <img src="<c:url value='/resources/img/apartments.png'/>" alt="Apartments">
                    <h2>Apartments</h2>
                </div>
                <div class="grid-item">
                    <img src="<c:url value='/resources/img/chalets.jpg'/>" alt="Chalets">
                    <h2>Chalets</h2>
                </div>
                <div class="grid-item">
                    <img src="<c:url value='/resources/img/house.jpg'/>" alt="Houses">
                    <h2>Houses</h2>
                </div>
            </div>
        </div> 
        
        <div class="footer">
            <h3>Contact Us: info@company.com | +123 456 7890</h3>
        </div>
    </div>
</body>
</html>
