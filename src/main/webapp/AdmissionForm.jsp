<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Student Admission Form</title>
<script src="https://translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
    <script type="text/javascript">
        // Define languages for translation
        var languages = {
            'en': 'English',
            'fr': 'French',
            'sw': 'Swahili'
        };

        function selectLanguage(code) {
            // Store selected language in cookie for persistence
            document.cookie = "chosenLang=" + code + "; expires=365; path=/";

            // Trigger page reload with translation parameter
            window.location.href = window.location.href + "?lang=" + code;
        }

        function googleTranslateElementInit() {
            // Retrieve selected language from cookie or parameter
            var selectedLang = document.cookie.match(/chosenLang=([^;]*)/) ? document.cookie.match(/chosenLang=([^;]*)/)[1] : (window.location.search.match(/lang=([^&]*)/) ? window.location.search.match(/lang=([^&]*)/)[1] : 'en');

            // Update button states and translate key elements
            for (var code in languages) {
                document.getElementById("lang_" + code).classList.remove("active");
                if (code === selectedLang) {
                    document.getElementById("lang_" + code).classList.add("active");
                    google.translate.element(document.getElementById("form-title"), "en", code);
                    google.translate.element(document.getElementById("translate-hint"), "en", code);
                }
            }
        }
    </script>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
    }
    .container {
        max-width: 600px;
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
    input[type="file"] {
        width: calc(100% - 20px);
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
    
        .profile {
        position: absolute;
        top: 20px;
        right: 20px;
        background-color: #f4f4f4;
        padding: 10px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
   
    .profile p {
        font-size: 18px;
        margin-bottom: 5px;
        text-decoration: underline;
    }
    
     .profile p:hover{
     cursor: pointer
     }
</style>
</head>
<body>
<div class="profile">
    <p><%= session.getAttribute("email") %></p>
</div>

<div class="container">

<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%-- Declare and initialize the languages map --%>
<% 
    Map<String, String> languages = new HashMap<>();
    languages.put("en", "English");
    languages.put("fr", "French");
    languages.put("sw", "Swahili");
%>
<%
    // Retrieve selected language from cookie or parameter
    String selectedLang = (String) request.getAttribute("selectedLang"); // Or however you're retrieving it
%>

<!--
<div class="language-bar">
    <h2>Translate Form:</h2>
    <div class="language-buttons">
        <% for (String code : languages.keySet()) { %>
            <button id="lang_<%= code %>" class="lang-button <%= code.equals(selectedLang) ? "active" : "" %>" onclick="selectLanguage('<%= code %>')"><%= languages.get(code) %></button>
        <% } %>
    </div>
    <p id="translate-hint">(Select language for full translation)</p>
</div>  -->
    <h2>Student Admission Form</h2>
   
    <form action="Admission" method="POST" enctype="multipart/form-data">
        <label for="firstname">First Name</label>
        <input type="text" id="firstname" name="firstname" required>

        <label for="lastname">Last Name</label>
        <input type="text" id="lastname" name="lastname" required>

        <label for="passport">Passport Picture (JPG or PNG)</label>
        <input type="file" id="passport" name="passport" accept="image/jpeg, image/png" required>

        <label for="certificate">Certificate (PDF)</label>
        <input type="file" id="certificate" name="certificate" accept="application/pdf" required>

        <input type="submit" value="Submit Admission">
        <div id="google_translate_element"></div>
    </form>
</div>

<%
    // Logic to check if the user is logged in
    HttpSession sessionCheck = request.getSession(false);
    Boolean loggedIn = (sessionCheck  != null && (Boolean) sessionCheck.getAttribute("loggedIn") == Boolean.TRUE);

    if (!loggedIn) {
        // User is not logged in, redirect to the login page
        response.sendRedirect("login.jsp");
    }
%>

</body>
</html>
