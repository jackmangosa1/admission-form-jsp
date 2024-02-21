<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login Form</title>
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
        background-color: #4caf50;
        color: white;
        padding: 12px 20px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        width: 100%;
    }
    input[type="submit"]:hover {
        background-color: #45a049;
    }
    .error-message {
        color: red;
        margin-top: 5px;
    }
</style>
</head>
<body>

<div class="container">
    <h2>Login</h2>
    <form id="login-form" action="" method="POST" onsubmit="return validateForm()">
        <label for="email">Email</label>
        <input type="text" id="email" name="email">
        <p id="email-error" class="error-message"></p>

        <label for="password">Password</label>
        <input type="password" id="password" name="password">
        <p id="password-error" class="error-message"></p>
        <p id="error-message" style="color: red;"></p>
         <p id="form-error" class="error-message" style="color: red;"></p>

        <input type="submit" value="Login">
    </form>
</div>


<%
    
        String loginEmail = request.getParameter("email");
        String loginPassword = request.getParameter("password");
        String signUpEmail = (String) session.getAttribute("email");
        String signUpPassword = (String) session.getAttribute("password");
        
    

       

        // Check if the entered credentials match the stored credentials
        if (loginEmail != null && loginPassword != null && signUpEmail != null && signUpPassword != null) {
            if (loginEmail.equals(signUpEmail) && loginPassword.equals(signUpPassword)) {
                // Valid credentials, set loggedIn attribute to true in session
                session.setAttribute("loggedIn", true);
                // Successful login, redirect to the dashboard or home page
                response.sendRedirect("AdmissionForm.jsp");
                return; // Stop further execution to prevent displaying error message
            } else {
            	 // Invalid credentials, set error message in the form
                out.println("<script>");
                out.println("document.getElementById('form-error').innerText = 'Invalid email or password';");
                out.println("</script>");
                return; // Stop further e
            }
        }
    
%>

<script>
    function validateForm() {
        var email = document.getElementById("email").value;
        var password = document.getElementById("password").value;
        var emailError = document.getElementById("email-error");
        var passwordError = document.getElementById("password-error");

        var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        // Reset error messages
        emailError.innerText = "";
        passwordError.innerText = "";

        if (email.trim() === '') {
            emailError.innerText = "Email is required.";
            return false;
        }

        // Validate email
        if (!email.match(emailPattern)) {
            emailError.innerText = "Please enter a valid email address.";
            return false;
        }

        // Validate password
        if (password.trim() === '') {
            passwordError.innerText = "Password is required.";
            return false;
        }

        return true;
    }
    
    function getErrorMessage() {
        var urlParams = new URLSearchParams(window.location.search);
        var error = urlParams.get('error');
        return error;
    }

    // Function to display error message on the form
    function displayErrorMessage() {
        var errorMessage = getErrorMessage();
        if (errorMessage) {
            document
