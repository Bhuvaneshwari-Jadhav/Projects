<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
    <link href="<c:url value='/resources/CSS/loginpage.css' />" rel="stylesheet" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
        integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
        crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css"
        integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU"
        crossorigin="anonymous">
</head>
<body>
    <div class="container">
        <div class="card card-container text-center">
            <img id="profile-img" class="profile-img-card"
                src="//ssl.gstatic.com/accounts/ui/avatar_2x.png" />
            <p id="profile-name" class="profile-name-card"></p>
            <form class="form-signin" name='frm' action='validate' method='POST'
                onsubmit="return validateForm()">
                <input type="text" class="form-control" name="uname"
                    placeholder="Username" required="required"> <span
                    id="usernameError" class="error-message"></span> <input
                    type="password" class="form-control" name="password"
                    placeholder="Password" required="required"> <span
                    id="passwordError" class="error-message"></span>
                <button class="btn btn-lg btn-primary btn-block btn-signin"
                    type="submit">Login</button>
            </form>
            <span style="color: red">${msg}</span>
        </div>
    </div>
    <script>
        function validateForm() {
            var uname = document.forms["frm"]["uname"].value;
            var password = document.forms["frm"]["password"].value;
            var usernameError = document.getElementById("usernameError");
            var passwordError = document.getElementById("passwordError");
            var valid = true;

            // Reset error messages
            usernameError.innerHTML = "";
            passwordError.innerHTML = "";

            // Username validation
            if (uname.trim() === "") {
                usernameError.innerHTML = "Username cannot be empty.";
                valid = false;
            }

            // Password validation
            var passwordPattern = /^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[\W_]).+$/;
            if (!passwordPattern.test(password)) {
                passwordError.innerHTML = "Password must contain at least one digit, one special character, and one letter.";
                valid = false;
            }

            return valid;
        }
    </script>
</body>
</html>
