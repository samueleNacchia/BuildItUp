<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="../css/LogIn_style.css">
    <link rel="stylesheet" href="../css/style_index.css">
    <link rel="stylesheet" href="../css/style_header.css">
    <link rel="stylesheet" href="../css/style_footer.css">
</head>
<body>

<div class="page-wrapper">
  <%@ include file="../common/header.jsp" %> 
  
    <div class="login-container">
        <h2>Accedi</h2>

        <% 
            String error = request.getParameter("error");
            String success = request.getParameter("success");
            if ("1".equals(error)) {
        %>
            <div class="error-msg-form">❌ Email o password errati.</div>
        <% } else if ("1".equals(success)) { %>
            <div class="success-msg">✅ Registrazione completata. Puoi effettuare il login.</div>
        <% } %>

	      <form id="loginForm" action="login" method="post">
	   		 <label for="email">Email:</label>
			    <input type="email" id="email" name="email" placeholder="example@gmail.com" required>
			    <span id="emailError" class="error-msg"></span>
				<br>
			    <label for="password">Password:</label>
			    <input type="password" id="password" name="password" placeholder="Password" required>
			    <span id="passwordError" class="error-msg"></span>
				<br>
			    <button class="login" type="submit">Login</button>
		</form>

        <br>

        <form action="Register_page.jsp" method="get">
            <button type="submit" class="register-button">Registrati</button>
        </form>
<script>
function resetError(id) {
    document.getElementById(id + "Error").textContent = "";
}

function validateEmail() {
    const email = document.getElementById("email").value.trim();
    resetError("email");
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
        document.getElementById("emailError").textContent = "Inserisci un'email valida.";
        return false;
    }
    return true;
}

function validatePassword() {
    const password = document.getElementById("password").value.trim();
    resetError("password");
    if (password.length === 0) {
        document.getElementById("passwordError").textContent = "Inserisci una password.";
        return false;
    }
    return true;
}

// Collega gli eventi onBlur
document.getElementById("email").addEventListener("blur", validateEmail);
document.getElementById("password").addEventListener("blur", validatePassword);

// Validazione al submit per sicurezza
document.getElementById("loginForm").addEventListener("submit", function (e) {
    if (!(validateEmail() & validatePassword())) {
        e.preventDefault();
    }
});
</script>

 
    
    </div>
           
 </div>

     <footer>
<%@ include file="../common/footer.html" %>
    </footer>
   
</body>
</html>
