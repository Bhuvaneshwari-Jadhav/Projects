<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Area</title>
    
    <!-- Custom and Bootstrap Stylesheets -->
    <link href="<c:url value='/resources/CSS/loginpage.css'/>" rel="stylesheet"/>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
          integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
          crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css"
          integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU"
          crossorigin="anonymous">
    
    <!-- Additional Custom Styling -->
    <style>
        .card-container.card {
            width: 40%;
            margin-top: 200px;
        }
        .btn-custom {
            background-color: #007bff;
            border-color: #007bff;
            color: white;
        }
        .btn-custom:hover {
            background-color: #0056b3;
            border-color: #004085;
        }
        .form-title {
            margin-bottom: 20px;
            font-weight: bold;
            color: #333;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .msg-success {
            color: green;
        }
        .msg-error {
            color: red;
            font-size: 12px;
        }
    </style>
</head>
<body>
    <!-- Include Header or Navigation -->
    <jsp:include page="adminpro.jsp"></jsp:include>

    <!-- Main Content Section -->
    <div class="card-container card">
        <h3>Add New Area</h3>
        <form class="form-signin" name="frm" action="savearea" method="POST" onsubmit="return validateForm()">
            <div class="form-group">
                <select name="id" class="form-control" required>
                    <option value="">Select City</option>
                    <c:forEach var="e" items="${clist}">
                        <option value="${e.getId()}">${e.getCname()}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <input type="text" class="form-control" name="aname" placeholder="Enter area name" required>
                <span id="areaNameError" class="msg-error"></span>
            </div>
            <button class="btn btn-custom btn-block" type="submit">Add Area</button>
            <span class="msg-success">${msg}</span>
        </form>
    </div>

    <!-- Include JS Scripts -->
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script>
    $(document).ready(function () {
        var areaList = [<c:forEach var="area" items="${existingAreas}">'${area.aname}',</c:forEach>]; // List of existing area names

        // Function to validate area name on input
        function validateAreaName() {
            var areaName = $('input[name="aname"]').val().trim();  // Get the trimmed area name
            var areaNameError = $('#areaNameError');  // Error message span

            // Reset error message
            areaNameError.text("");

            // Check if area name is empty or only contains spaces
            if (areaName === "") {
                areaNameError.text("Area name cannot be empty.");
                return false;
            }

            // Check if area name starts with a space
            if (/^\s/.test(areaName)) {
                areaNameError.text("Area name cannot start with a space.");
                return false;
            }

            // Check if area name length is less than or equal to 3 characters
            if (areaName.length <= 2) {
                areaNameError.text("Area name must be more than 2 characters long.");
                return false;
            }

            // Check if area name contains digits
            if (/\d/.test(areaName)) {
                areaNameError.text("Area name cannot contain numbers.");
                return false;
            }

            // Check if area name contains special characters (only allows letters and spaces)
            if (/[^a-zA-Z\s]/.test(areaName)) {
                areaNameError.text("Area name cannot contain special characters.");
                return false;
            }

            // Check if area name is a duplicate
            if (areaList.includes(areaName)) {
                areaNameError.text("Area name already exists.");
                return false;
            }

            return true;
        }

        // Attach the input event listener to validate in real-time
        $('input[name="aname"]').on('input', function () {
            validateAreaName();  // Call validation function on each input change
        });
    });
</script>

</body>
</html>
