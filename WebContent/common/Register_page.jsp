<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registrazione</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Register_style.css?v=<%= System.currentTimeMillis() %>">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    

    
</head>
<body>
<div class="page-wrapper">
    <%@ include file="header.jsp" %>
    <div class="register-container">
        <h2>Registrazione</h2>

        <c:if test="${param.error == 'pwd'}">
		    <div class="error-top"> ⚠️ Le password non corrispondono. Riprova.</div>
		</c:if>
		
		<c:if test="${param.error == 'dupe'}">
		    <div class="error-top"> ⚠️ L'email è già registrata. Riprova.</div>
		</c:if>


	    <form id="registerForm" action="register" method="post" novalidate>
	
		    <label>Email:</label>
		    <input type="email" id="email" name="email" placeholder="example@gmail.com" required>
		    <div class="error" id="emailError"></div>
		
		    <label>Password:</label>
		    <input type="password" id="password" name="password" placeholder="password" required>
		    <div class="error" id="passwordError"></div>
		
		    <label>Conferma Password:</label>
		    <input type="password" id="confirm" name="confirm" placeholder="Confirm password" required>
		    <div class="error" id="confirmError"></div>
		
		    <label>Nome:</label>
		    <input type="text" id="nome" name="nome" placeholder="Francesco" required>
		    <div class="error" id="nomeError"></div>
		
		    <label>Cognome:</label>
		    <input type="text" id="cognome" name="cognome" placeholder="Totti" required>
		    <div class="error" id="cognomeError"></div>
		
		    <label>Cellulare:</label>
		    <input type="text" id="cell" name="cell" placeholder="012 345 6789" required>
		    <div class="error" id="cellError"></div>
		
		    <label>Indirizzo:</label>
		    <input type="text" id="ind" name="ind" placeholder="Via Roma" required>
		    <div class="error" id="indError"></div>
		
		    <label>Civico:</label>
		    <input type="text" id="civ" name="civ" placeholder="1" required>
		    <div class="error" id="civError"></div>
		
		    <label>CAP:</label>
		    <input type="text" id="cap" name="cap" placeholder="84001" required>
		    <div class="error" id="capError"></div>
		
		    <label>Provincia:</label>
		    <input type="text" id="prov" name="prov" placeholder="SA" required>
		    <div class="error" id="provError"></div>
		
		    <button class ="reg"type="submit">Registrati</button>
		</form>
	
	
	
	    <form action="LogIn_page.jsp" method="post">
	    	<button type="submit" class="log">Torna al Login</button>
	    </form>
        
        
        
        
		<script src="${pageContext.request.contextPath}/script/registerScript.js"></script>
       
    </div>
      <%@ include file="footer.jsp" %>
</div>



</body>
</html>
