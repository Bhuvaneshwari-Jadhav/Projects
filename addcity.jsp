<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add City</title>
    <link href="<c:url value='/resources/CSS/loginpage.css'/>" rel="stylesheet"/>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Arial', sans-serif;
        }
        .card-container.card {
            width: 40%;
            margin-top: 200px;
        }
        h3 {
            color: #333;
            margin-bottom: 20px;
        }
        .btn-signin {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-signin:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }
        .error-msg, .success-msg {
            margin-top: 15px;
            font-size: 14px;
            display: none;
        }
        .error-msg {
            color: #dc3545;
        }
        .success-msg {
            color: #28a745;
        }
    </style>
</head>
<body>
    <jsp:include page="adminpro.jsp"></jsp:include>
    <div class="card-container card">
        <h3>Add New City</h3>
        <form id="addCityForm" class="form-signin" action="${pageContext.request.contextPath}/save" method="POST">
            <div class="form-group">
                <input type="text" class="form-control" id="cname" name="cname" placeholder="Enter City Name" required>
            </div>
            <button class="btn btn-lg btn-primary btn-block btn-signin" type="submit">Add City</button>
            <div id="error-msg" class="error-msg">
                <c:if test="${not empty message}">
                    ${message}
                </c:if>
            </div>
        </form>
        <div id="success-msg" class="success-msg">
            <c:if test="${not empty successMessage}">
                ${successMessage}
            </c:if>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script>
        $(document).ready(function() {
            function showError(msg) {
                $('#error-msg').text(msg).show();
                $('#success-msg').hide();
            }

            function showSuccess(msg) {
                $('#success-msg').text(msg).show();
                $('#error-msg').hide();
            }

            $('#cname').on('input', function() {
                var cname = $(this).val().trim();
                var errorMsg = '';

                if (cname === '') {
                    errorMsg = 'Please enter a city name!';
                } else if (/\d/.test(cname)) {
                    errorMsg = 'Invalid city name! City name should not contain digits.';
                } else if (!/^[a-zA-Z ]+$/.test(cname)) {
                    errorMsg = 'Invalid city name! Only alphabets and spaces are allowed.';
                } else if (cname.length <= 2) {
                    errorMsg = 'City name must be more than 2 characters long.';
                } else if (/^\s|\s$/.test(cname)) {
                    errorMsg = 'City name should not start or end with spaces.';
                }

                if (errorMsg) {
                    showError(errorMsg);
                } else {
                    $('#error-msg').hide();
                    // Check if city name already exists
                    $.ajax({
                        type: 'GET',
                        url: '${pageContext.request.contextPath}/checkCityName',
                        data: { cname: cname },
                        success: function(data) {
                            if (data === 'true') {
                                showError('City name already exists! Please enter a different name.');
                            } else {
                                $('#error-msg').hide();
                            }
                        }
                    });
                }
            });

            $('#addCityForm').submit(function(event) {
                var cname = $('#cname').val().trim();
                var errorMsg = '';

                if (cname === '') {
                    errorMsg = 'Please enter a city name!';
                } else if (/\d/.test(cname)) {
                    errorMsg = 'Invalid city name! City name should not contain digits.';
                } else if (!/^[a-zA-Z ]+$/.test(cname)) {
                    errorMsg = 'Invalid city name! Only alphabets and spaces are allowed.';
                } else if (cname.length <= 3) {
                    errorMsg = 'City name must be more than 3 characters long.';
                } else if (/^\s|\s$/.test(cname)) {
                    errorMsg = 'City name should not start or end with spaces.';
                }

                if (errorMsg) {
                    showError(errorMsg);
                    event.preventDefault();
                    return;
                }

                // Check if city name already exists before submitting
                $.ajax({
                    type: 'GET',
                    url: '${pageContext.request.contextPath}/checkCityName',
                    data: { cname: cname },
                    async: false,
                    success: function(data) {
                        if (data === 'true') {
                            showError('City name already exists! Please enter a different name.');
                            event.preventDefault();
                        } else {
                            $('#error-msg').hide();
                            showSuccess('City added successfully!');
                        }
                    }
                });
            });
        });
    </script>
</body>
</html>
