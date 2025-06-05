<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="css/LogIn_style.css">
    <link rel="stylesheet" href="css/style_index.css">
    <link rel="stylesheet" href="css/style_header.css">
    <link rel="stylesheet" href="css/style_footer.css">
</head>
<body>

<div class="page-wrapper">
  <%@ include file="header.html" %> 
  
    <div class="login-container">
        <h2>Accedi</h2>

        <% 
            String error = request.getParameter("error");
            String success = request.getParameter("success");
            if ("1".equals(error)) {
        %>
            <div class="error-msg">❌ Email o password errati.</div>
        <% } else if ("1".equals(success)) { %>
            <div class="success-msg">✅ Registrazione completata. Puoi effettuare il login.</div>
        <% } %>

        <form action="login" method="post">

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" placeholder ="example@gmail.com" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" placeholder ="Password" required>

            <button type="submit">Login</button>
        </form><br>

        <form action="Register_page.jsp" method="get">
            <button type="submit" class="register-button">Registrati</button>
        </form>
        <script> 
        </script>
    </div>
 
     <%@ include file="footer.html" %>
    </div>
</body>
</html>
