<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contattaci - Build It Up</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_contact.css">
	
	<style>html{display:none;}</style>
</head>
<body>
	<%@ include file="header.jsp" %>
	
	<br><br>

	<main style="flex: 1">
	    <div class="contact-form">
	    
	        <h2>Contattaci</h2>
	        
	        <form action="${pageContext.request.contextPath}/ContactServlet" method="post">
	        
	            <label for="email">Email:</label>
			    <input type="email" id="email" name="email" placeholder="example@gmail.com" maxlength="100" required>
			    <span id="emailError" class="error-msg"></span>
	            <textarea name="message" placeholder="Il tuo messaggio" rows="6" maxlength="500" required></textarea>
	            <button type="submit">Invia</button>
	            
	        </form>
	        
	    </div>
	</main>
	
	
	<script src="${pageContext.request.contextPath}/script/contactScript.js"></script>
	
	<%@ include file="footer.jsp" %>
</body>
</html>
