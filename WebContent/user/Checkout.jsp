<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Riepilogo Ordine</title>
    <style>html{display:none}</style>
    <%@ include file="/common/header.jsp" %>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_checkout.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <script src="${pageContext.request.contextPath}/script/checkoutValidation.js"></script>  

</head>
<body>
<div class="page-wrapper">

    <main class="homepage">
        <h2 class="center-title">Riepilogo del tuo ordine</h2>

        <table>
           

            <c:set var="total" value="0" />

            <c:forEach var="item" items="${items}">
                <c:set var="product" value="${item.product}" />
                <c:set var="quantity" value="${item.quantity}" />
                <c:set var="price" value="${product.price * (1 - product.discount)}" />
                <c:set var="subtotal" value="${quantity * price}" />
                <c:set var="total" value="${total + subtotal}" />

                <tr>
                    <td data-label="Nome">${product.name}</td>
                    <td data-label="Quantità">${quantity}</td>
                    <td data-label="Prezzo">€ <fmt:formatNumber value="${price}" maxFractionDigits="2" /></td>
                    <td data-label="Subtotale">€ <fmt:formatNumber value="${subtotal}" maxFractionDigits="2" /></td>
                </tr>
            </c:forEach>

            <tr class="totale">
                <td colspan="3"><strong>Totale</strong></td>
                <td><strong>€ <fmt:formatNumber value="${total}" maxFractionDigits="2" /></strong></td>
            </tr>
        </table>
<div class="form-row">
       
	<div class="container">
    <h3>Riepilogo Indirizzo e Dati Carta</h3>

   <form action="${pageContext.request.contextPath}/user/SaveOrder" id="checkoutForm" method="post" >

		  <div class="form-row">
		    <div id="addressSection">
		     
		      <div id="addressDisplay">
		        <p>
		            ${userAddress.via}, ${userAddress.roadNum} <br> ${userAddress.postalCode} (${userAddress.provincia})
		        </p>
		        <button type="button" id="editAddressBtn">Modifica Indirizzo</button>
		      </div>
		
		      <div id="addressFields" style="display:none; margin-top: 15px;">
    
			    <label for="street">Via:</label>
			    <input type="text" id="street" name="street" value="${userAddress.via}" placeholder="Es: Via Roma" maxlength="100" required onblur="validateInd()">
			    <br>
			    <span id="streetError" class="error-message"></span>
			
			    <label for="civic">Civico:</label>
			    <input type="number" id="civic" name="civic" value="${userAddress.roadNum}" placeholder="Es: 12/A" required onblur="validateCiv()">
			    <span id="civicError" class="error-message"></span>
			
			    <label for="zip">CAP:</label>
			    <input type="number" id="zip" name="zip" value="${userAddress.postalCode}" placeholder="Es: 00100" maxlength="5" required onblur="validateCap()">
			    <br>
			    <span id="zipError" class="error-message"></span>
			
			    <label for="province">Provincia:</label>
			    <input type="text" id="province" name="province" value="${userAddress.provincia}" maxlength="2" required>
  				<br>
  				<span id="provinceError" class="error"></span>
			</div>

		    </div>
		
		    <div id="paymentSection">
		      
		      <h3>Dati della Carta</h3>
		     	<label for="cardNumber">Numero Carta:</label>
				<input type="text" id="cardNumber" name="cardNumber" maxlength="19" placeholder="XXXX XXXX XXXX XXXX" required>
				<span id="cardNumberError" class="error-message"></span>
				
				<label for="expiry">Scadenza (MM/AA):</label>
				<input type="text" id="expiry" name="expiry" maxlength="5" placeholder="MM/AA" required>
				<span id="expiryError" class="error-message"></span>
				
				<label for="cvv">CVV:</label>
				<input type="text" id="cvv" name="cvv" maxlength="4" placeholder="CVV" required>
				<span id="cvvError" class="error-message"></span>
				</div>
		  </div>
		
		  <br><br>
		  
		  <div id="confirm">
		  <input class="add" type="submit" value="Conferma ordine">
		  </div>
		</form>
		
		</div>
		</div>
      
    </main>
</div>

<%@ include file="/common/footer.jsp" %>

<script src="${pageContext.request.contextPath}/script/checkoutScript.js"></script>
<script src="${pageContext.request.contextPath}/script/indexScript.js"></script>
</body>
</html>
