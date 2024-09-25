<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update City</title>
    <link href="<c:url value='/resources/CSS/style.css'/>" rel="stylesheet" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" crossorigin="anonymous">
    <style>
        body {
            background-color: #f8f9fa;
            color: #343a40;
        }
        .container {
            margin-top: 50px;
            margin-left:300px;
        }
        .card-container .card
        {
        margin-top:100px;}
        .btn-primary {
       
            background-color: #007bff;
            border-color: #007bff;
        }
        .alert {
            margin-top: 20px;
        }
    </style>
</head>
<body>
 <jsp:include page="adminpro.jsp"></jsp:include>
    <div class="container">
        <div class="card-container card">
            <h2 >Update City</h2>

            <!-- Display success or error message -->
            <c:if test="${not empty message}">
                <div class="alert alert-success">
                    <strong>Success!</strong> ${message}
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <strong>Error!</strong> ${error}
                </div>
            </c:if>

            <!-- City update form -->
            <form action="${pageContext.request.contextPath}/saveupdate" method="post">
                <div class="form-group">
                    <label for="cname">City Name:</label>
                    <input type="text" class="form-control" id="cname" name="cname" value="${city.cname}" required />
                </div>
                <input type="hidden" name="id" value="${city.id}" />
                <button type="submit" class="btn btn-primary ">Update City</button>
            </form>
            <br>
            <a href="${pageContext.request.contextPath}/viewcitylist" class="btn btn-secondary ">Back to City List</a>
        </div>
    </div>

    <!-- Bootstrap JS for form functionality -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" crossorigin="anonymous"></script>
</body>
</html>
