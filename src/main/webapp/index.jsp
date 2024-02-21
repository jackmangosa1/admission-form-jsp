<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sign Up Form</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
    }
    .container {
        max-width: 400px;
        margin: 50px auto;
        padding: 20px;
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    h2 {
        text-align: center;
        margin-bottom: 20px;
    }
    label {
        display: block;
        margin-bottom: 8px;
    }
    input[type="text"],
    input[type="password"] {
        width: 100%;
        padding: 10px;
        margin-bottom: 20px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }
    input[type="submit"] {
        background-color: #0057ff;
        color: white;
        padding: 12px 20px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        width: 100%;
    }
    input[type="submit"]:hover {
        background-color: rgba(0,87,255, 0.6);
    }
    .error-message {
        color: red;
        margin-top: 5px;
    }
</style>
</head>
<body>

<div class="container">
    <h2>Sign Up</h2>
    <form id="signup-form" action="" method="POST" onsubmit="return validateForm()">
        <label for="email">Email</label>
        <input type="text" id="email" name="email">
        <p id="email-error" class="error-message"></p>

        <label for="password">Password</label>
        <input type="password" id="password" name="password">
        <p id="password-error" class="error-message"></p>

        <label for="confirmPassword">Confirm Password</label>
        <input type="password" id="confirmPassword" name="confirmPassword">
        <p id="confirmPassword-error" class="error-message"></p>

        <input type="submit" value="Sign Up">
    </form>
</div>

<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");


    if (email != null && password != null) {
      

        // Store the user's email and password in session attributes
        session.setAttribute("email", email);
        session.setAttribute("password", password);
        
        String signUpEmail = (String) session.getAttribute("email");
        String signUpPassword = (String) session.getAttribute("password");
        
        out.println("loginEmail: " + signUpEmail); // Debug
        out.println("loginPassword: " + signUpPassword); // Debug

        
        // Redirect to the login page after sign-up
        response.sendRedirect("login.jsp");
    }
%>

<script>
    function validateForm() {
        var email = document.getElementById("email").value;
        var password = document.getElementById("password").value;
        var confirmPassword = document.getElementById("confirmPassword").value;
        var emailError = document.getElementById("email-error");
        var passwordError = document.getElementById("password-error");
        var confirmPasswordError = document.getElementById("confirmPassword-error");

        var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        // Reset error messages
        emailError.innerText = "";
        passwordError.innerText = "";
        confirmPasswordError.innerText = "";

        // Validate email
        if (email.trim() === '') {
            emailError.innerText = "Email is required.";
            return false;
        }
        if (!email.match(emailPattern)) {
            emailError.innerText = "Please enter a valid email address.";
            return false;
        }

        // Validate password
        if (password.trim() === '') {
            passwordError.innerText = "Password is required.";
            return false;
        }

        // Validate confirm password
        if (confirmPassword.trim() === '') {
            confirmPasswordError.innerText = "Please confirm your password.";
            return false;
        }

        if (password !== confirmPassword) {
            confirmPasswordError.innerText = "Password and confirm password do not match.";
            return false;
        }

        return true;
    }
</script>

</body>
</html>
