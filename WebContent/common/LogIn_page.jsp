<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/LogIn_style.css?v=<%= System.currentTimeMillis() %>">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    

</head>
<body>

<div class="page-wrapper">
  <%@ include file="header.jsp" %> 
  
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

        <form action="Register_page.jsp" method="post">
            <button type="submit" class="register-button">Registrati</button>
        </form>
<script src="${pageContext.request.contextPath}/script/logInScript.js"></script>

 
    
    </div>
           
 </div>

     <footer>
<%@ include file="footer.jsp" %>
    </footer>
   
</body>
</html>
