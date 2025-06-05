<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registrazione</title>
    <link rel="stylesheet" href="css/Register_style.css">
    <link rel="stylesheet" href="css/style_index.css?v=<%= System.currentTimeMillis() %>">
    <link rel="stylesheet" href="./css/style_header.css?v=<%= System.currentTimeMillis() %>">
    <link rel="stylesheet" href="./css/style_footer.css?v=<%= System.currentTimeMillis() %>">
    
</head>
<body>
<div class="page-wrapper">
    <%@ include file="header.html" %>
    <div class="register-container">
        <h2>Registrazione</h2>

        <%
            String error = request.getParameter("error");
            if ("pwd".equals(error)) {
        %>
            <div class="error-msg"> ⚠️ Le password non corrispondono. Riprova.</div>
        <%
            }
        %>

        <form action="register" method="post">

            <label>Email:</label>
            <input type="email" name="email" placeholder="example@gmail.com" required><br><br>

            <label>Password:</label>
            <input type="password" name="password" placeholder="password" required><br><br>

            <label>Conferma Password:</label>
            <input type="password" name="confirm" placeholder="Confirm password" required><br><br>

            <label>Nome:</label>
            <input type="text" name="nome"  placeholder="Francesco"  required><br><br>

            <label>Cognome:</label>
            <input type="text" name="cognome" placeholder="Totti" required><br><br>

            <label>Cellulare:</label>
            <input type="text" name="cell" placeholder="012 345 6789" required><br><br>

            <label>Indirizzo:</label>
            <input type="text" name="ind"  placeholder="Via Roma" required><br><br>

            <label>Civico:</label>
            <input type="text" name="civ" placeholder="1" required><br><br>

            <label>CAP:</label>
            <input type="text" name="cap" placeholder="84001" required><br><br>

            <label>Provincia:</label>
            <input type="text" name="prov" placeholder="SA" required><br><br>

            <button type="submit">Registrati</button>
        </form>

        <form action="LogIn_page.jsp" method="get">
            <button type="submit" class="register-button">Torna al Login</button>
        </form>
    </div>
      <%@ include file="footer.html" %>
</div>
</body>
</html>
