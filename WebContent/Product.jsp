<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="model.Product.ProductDTO" %>
<%@ page import="model.ProductImage.ProductImageDTO" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

    
<%
    ProductDTO p = (ProductDTO) request.getAttribute("prodotto");
	List<ProductImageDTO> immagini = (List<ProductImageDTO>) request.getAttribute("immagini");

	if (p == null) {
%>
    <p>Prodotto non trovato.</p>
<%
    return;
    }
%>


<!DOCTYPE html>
<html>
<head>


<script>
   

	window.addEventListener("load", () => {
	    const imagesContainer = document.getElementById("carouselImages");
	    const images = imagesContainer.querySelectorAll("img");
	
	    const totalImages = images.length;
	
	    if (totalImages === 0) {
	        console.warn("Nessuna immagine trovata nel carosello.");
	        return;
	    }
	
	    let currentIndex = 0;
	
	    function updateCarousel() {
	        const offset = -currentIndex * 100;
	        imagesContainer.style.transform = `translateX(${offset}%)`;
	    }
	
	    window.nextImage = function () {
	        currentIndex = (currentIndex + 1) % totalImages;
	        updateCarousel();
	    };
	
	    window.prevImage = function () {
	        currentIndex = (currentIndex - 1 + totalImages) % totalImages;
	        updateCarousel();
	    };
	
	    // Forza la larghezza del contenitore in base al numero di immagini
	    imagesContainer.style.width = `${100 * totalImages}%`;
	
	    // Assicura che ogni immagine abbia larghezza 100% del carosello
	    images.forEach(img => img.style.width = `${100 / totalImages}%`);
	
	    updateCarousel();
	});
	


    function changeQty(delta) {
      const input = document.getElementById("quantity");
      let current = parseInt(input.value);
      const max = parseInt(input.max);
      if (isNaN(current)) current = 1;
      let newValue = Math.min(Math.max(1, current + delta), max);
      input.value = newValue;
    }
    
    
    function syncQuantity(form) {
        const qtyInput = document.getElementById("quantity");
        const hiddenInput = form.querySelector('input[name="quantity"]');
        if (qtyInput && hiddenInput) {
            hiddenInput.value = qtyInput.value;
        }
    }

  </script>



<meta charset="UTF-8">
<title></title>

	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="./css/style_header.css?v=<%= System.currentTimeMillis() %>">
    <link rel="stylesheet" href="./css/style_footer.css?v=<%= System.currentTimeMillis() %>">
    <link rel="stylesheet" href="./css/style_product.css?v=<%= System.currentTimeMillis() %>">


</head>
<body>
<div class="page-wrapper">
    <%@ include file="header.html" %>

    <main class="homepage">
    
    
  		<div class="product-wrapper">
  
    		<div class="carousel">
    		
			      <div class="carousel-images" id="carouselImages">
			      
			      		<c:forEach var="img" items="${immagini}">
			      		
						    <c:choose>
						        <c:when test="${not empty img}">
						            <img src="image?id=${img.id}">
						        </c:when>
						        <c:otherwise>
						            <img src="img/default.jpg" alt="Nessuna immagine disponibile">
						        </c:otherwise>
						    </c:choose>
						    
						</c:forEach>

			    </div>
			    
			    <button class="carousel-button prev" onclick="prevImage()">‹</button>
				<button class="carousel-button next" onclick="nextImage()">›</button>
					    
			</div>


		    <div class="product-details">
		    
			      <h1 class="product-title"><%= p.getName() %></h1>
			      <p class="product-description"><%= p.getDescription() %></p>
			      
			      <%
						double prezzo = p.getPrice();
						double sconto = p.getDiscount();
						double prezzoScontato = prezzo;
						if (sconto > 0) {
						    prezzoScontato = prezzo * (1 - sconto);
						}
						request.setAttribute("prezzoScontato", prezzoScontato);
				   %>
			      
			      <c:choose>
				    <c:when test="${prodotto.discount > 0}">
				        <div class="product-price">
				            <span class="original-price" style="text-decoration: line-through; color: red;">
				                ${prodotto.price}€
				            </span>
				            <span class="discounted-price" style="color: green; font-weight: bold; margin-left: 10px;">
				                <fmt:formatNumber value="${prezzoScontato}" type="number" maxFractionDigits="2" />€
				            </span>
				        </div>
				    </c:when>
				    <c:otherwise>
				        <div class="product-price">
				            ${prodotto.price}€
				        </div>
				    </c:otherwise>
				  </c:choose>
			      
		
			      <div class="quantity-selector">
				    <label for="quantity">Quantità:</label>
				    <button type="button" onclick="changeQty(-1)">−</button>
				    <input type="number" id="quantity" name="quantity" value="1" min="1" max="<%= p.getStocks() %>">
				    <button type="button" onclick="changeQty(1)">+</button>
				  </div>
				
				
				  <div class="action-buttons">
				  	<button type="button" class="wishlist" onclick="addToList('wishlist', <%= p.getId() %>)">
				    	<i class="fa-regular fa-heart"></i> Wishlist
				    </button>
				    
				   	<button type="button" class="add-to-cart" onclick="addToList('cart', <%= p.getId() %>)">
				    	<i class="fa-solid fa-cart-shopping"></i> Aggiungi al carrello
				    </button>
				 </div>

			      
		    </div>
  		
  		</div>
</main>

<div id="toast" class="toast">Prodotto aggiunto!</div>

	
	
    <%@ include file="footer.html" %>
</div>



</body>
</html>