<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contattaci - Build It Up</title>
    <style>
    
        html, body {
		    height: 100%;
		    margin: 0;
		    display: flex;
		    flex-direction: column;
		}
		
		body {
		    font-family: Arial, sans-serif;
		    padding: 0;
		    background-color: #f4f4f4;
		}
		
		main {
		    flex: 1;
		    display: flex;
		    justify-content: center;
		    align-items: center;
		}
		
		.contact-form {
		    background: white;
		    max-width: 600px;
		    width: 100%;
		    padding: 30px;
		    border-radius: 10px;
		    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
		    text-align: center;
		}
		
		.contact-form h2 {
		    margin-bottom: 20px;
		}
		
		.contact-form input, .contact-form textarea {
		    width: 80%;
		    padding: 12px;
		    margin-bottom: 15px;
		    border: 1px solid #ccc;
		    border-radius: 5px;
		    display: block;
		    margin-left: auto;
		    margin-right: auto;
		}
		
		.contact-form button {
		    background-color: #333;
		    color: white;
		    border: none;
		    padding: 12px 20px;
		    border-radius: 5px;
		    cursor: pointer;
		    display: block;
		    margin: 0 auto;
		}
		
		.contact-form button:hover {
		    background-color: #555;
		}

        
        
    </style>
</head>
<body>
	<%@ include file="header.jsp" %>
	
	<br><br>

	<main style="flex: 1">
	    <div class="contact-form">
	    
	        <h2>Contattaci</h2>
	        
	        <form action="${pageContext.request.contextPath}/ContactServlet" method="post">
	        
	            <label for="email">Email:</label>
			    <input type="email" id="email" name="email" placeholder="example@gmail.com" required>
			    <span id="emailError" class="error-msg"></span>
	            <textarea name="message" placeholder="Il tuo messaggio" rows="6" maxlength="500" required></textarea>
	            <button type="submit">Invia</button>
	            
	        </form>
	        
	    </div>
	</main>
	<script src="${pageContext.request.contextPath}/script/logInScript.js"></script>
	<%@ include file="footer.jsp" %>
</body>
</html>
