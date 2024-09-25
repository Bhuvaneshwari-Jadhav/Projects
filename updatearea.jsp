<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Area</title>
    <link href="<c:url value='/resources/CSS/style.css'/>" rel="stylesheet" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" crossorigin="anonymous">
    <style>
        body {
            background-color: #f8f9fa;
            color: #343a40;
        }
        .container {
            margin-top: 150px;
            margin-left: 300px;
        }
        .card-container .card {
            margin-top: 100px;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .alert {
            margin-top: 20px;
        }
        .msg-error {
            color: red;
            font-size: 12px;
        }
    </style>
</head>
<body>
    <jsp:include page="adminpro.jsp"></jsp:include>
    <div class="container">
        <div class="card-container card">
            <h2>Update Area</h2>
            <form name="frm" action="areaupdated" method="post" onsubmit="return validateForm()">
                <!-- Hidden field for area ID -->
                <input type="hidden" name="aid" value="${area.aid}" />
                
                <!-- Text input for area name -->
                <label for="aname">Area Name: </label>
                <input type="text" class="form-control" id="aname" name="aname" value="${area.aname}" placeholder="Enter area name" required>
                <span id="areaNameError" class="msg-error"></span>
                <br>
                <!-- Submit button -->
                <button class="btn btn-lg btn-primary btn-block btn-signin" name="s" type="submit">Update Area</button>
            </form>
            <br>
            <span style="color:green" class="text-center">${msg}</span>
        </div>
    </div>

    <!-- jQuery for real-time validation -->
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

    <!-- Real-time Validation -->
    <script>
        $(document).ready(function () {
            function validateAreaName() {
                var areaName = $('#aname').val().trim(); // Remove leading/trailing spaces
                var areaNameError = $('#areaNameError');

                // Reset error message
                areaNameError.text("");

                // Validation: Check if the area name is empty
                if (areaName === "") {
                    areaNameError.text("Area name cannot be empty.");
                    return false;
                }

                // Validation: Check if area name starts with a space
                if (/^\s/.test(areaName)) {
                    areaNameError.text("Area name cannot start with a space.");
                    return false;
                }

                // Validation: Check if area name contains digits
                if (/\d/.test(areaName)) {
                    areaNameError.text("Area name cannot contain numbers.");
                    return false;
                }

                // Validation: Check if area name contains special characters
                if (/[^a-zA-Z\s]/.test(areaName)) {
                    areaNameError.text("Area name cannot contain special symbols.");
                    return false;
                }

                // Validation: Area name should be more than 3 characters long
                if (areaName.length <= 3) {
                    areaNameError.text("Area name must be more than 3 characters long.");
                    return false;
                }

                return true; // All validations passed
            }

            // Real-time validation as the user types
            $('#aname').on('input', function () {
                validateAreaName();
            });

            // Form submit validation
            $('form[name="frm"]').on('submit', function () {
                return validateAreaName(); // Prevent form submission if validation fails
            });
        });
    </script>
</body>
</html>