<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Hotel Category</title>
    <link href="<c:url value='/resources/CSS/loginpage.css'/>" rel="stylesheet"/>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" crossorigin="anonymous">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Arial', sans-serif;
        }
        .card-container.card {
            width: 40%;
            margin-top: 200px;
        }
        .error-msg, .success-msg {
            font-size: 14px;
            margin-top: 10px;
        }
        .error-msg {
            color: #dc3545;
            display: none;
        }
        .success-msg {
            color: #28a745;
            display: none;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        function validateCategoryName() {
            var categoryName = document.getElementById("htype").value.trim();
            var errorMessage = "";

            // Validation rules
            if (categoryName === "") {
                errorMessage = "Category name is required.";
            } else if (categoryName.length <= 2) {
                errorMessage = "Category name must be longer than 2 characters.";
            } else if (/^\s/.test(categoryName)) {
                errorMessage = "Category name cannot start with a space.";
            } else if (!/^[a-zA-Z ]+$/.test(categoryName)) {
                errorMessage = "Category name must only contain letters and spaces.";
            }

            if (errorMessage) {
                document.getElementById("error-msg").innerText = errorMessage;
                document.getElementById("error-msg").style.display = "block";
                return false;
            } else {
                document.getElementById("error-msg").style.display = "none";
                return true;
            }
        }

        function checkCategoryExists() {
            var categoryName = document.getElementById("htype").value.trim();

            if (categoryName === "") {
                $('#error-msg').hide();
                $('#success-msg').hide();
                return;
            }

            $.ajax({
                url: 'checkCategoryExists', // Change to the actual endpoint URL
                type: 'POST',
                data: { htype: categoryName },
                success: function(response) {
                    if (response.exists) {
                        $('#error-msg').text('Category name already exists. Enter another category.').show();
                        $('#success-msg').hide();
                    } else {
                        $('#error-msg').hide();
                        $('#success-msg').text('Category is available.').show();
                    }
                },
                
            });
        }

        $(document).ready(function() {
            $('#htype').on('input', function() {
                if (validateCategoryName()) {
                    checkCategoryExists();
                }
            });
        });
    </script>
</head>
<body>
    <jsp:include page="adminpro.jsp"></jsp:include>
    <div class="card-container card">
        <h4>Add Hotel Category</h4>
        <form id="addCategoryForm" class="form-signin" action="savecat" method="POST" onsubmit="return validateCategoryName()">
            <div class="form-group">
                <input type="text" class="form-control" id="htype" name="htype" placeholder="Enter Category" required>
                <div id="error-msg" class="error-msg"></div>
                <div id="success-msg" class="success-msg"></div>
            </div>
            <button class="btn btn-lg btn-primary btn-block btn-signin" type="submit">Add Category</button>
        </form>
        <span style="color:green" class="text-center">${msg}</span>
    </div>
</body>
</html>
