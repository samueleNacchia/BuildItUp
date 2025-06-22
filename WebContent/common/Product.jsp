<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${empty prodotto}">
    <p>Prodotto non trovato.</p>
    
</c:if>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link rel="stylesheet" href="../css/style_header.css?v=<%= System.currentTimeMillis() %>">
<link rel="stylesheet" href="../css/style_footer.css?v=<%= System.currentTimeMillis() %>">
<link rel="stylesheet" href="../css/style_product.css?v=<%= System.currentTimeMillis() %>">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />



</head>
<body>
<div class="page-wrapper">
    <%@ include file="../common/header.jsp" %>

    <main class="homepage">
    
    
    
        <div class="product-wrapper">

			<div class="swiper mySwiper">
				<div class="swiper-wrapper">
					<c:forEach var="image" items="${immagini}">
				    	<div class="swiper-slide">
				        	<img src="image?id=${image.id}" style="width: 100%; height: 400px; object-fit: contain;" />
				     	</div>
			    	</c:forEach>
			  </div>
			  
			  <div class="swiper-button-next"></div>
			  <div class="swiper-button-prev"></div>

			  <div class="swiper-pagination"></div>
			</div>




            <div class="product-details">
    			<h1 class="product-title">${prodotto.name}</h1>
    			    			<span class="stars">
	    			<c:forEach begin="1" end="5" var="i">Add commentMore actions
						<i class="fa-star <c:out value='${i <= prodotto.avgReview ? "fas" : "far"}'/>"></i>
					</c:forEach>
					(${prodotto.numReview})
				</span>
    			
    			<p class="product-description">${prodotto.description}</p>

	    		<c:choose>
	        		<c:when test="${not prodotto.onSale}">
			            <div class="not-available" style="color: red; font-weight: bold;">
			                Non disponibile
			            </div>
	        		</c:when>
	
		        	<c:otherwise>
			            <c:set var="prezzoScontato" value="${prodotto.price}" />
			            <c:if test="${prodotto.discount > 0}">
			                <c:set var="prezzoScontato" value="${prodotto.price * (1 - prodotto.discount)}" />
			            </c:if>
		
			            <div class="product-price">
			                <c:choose>
			                    <c:when test="${prodotto.discount > 0}">
			                        <span class="original-price" style="text-decoration: line-through; color: red;">
			                            <fmt:formatNumber value="${prodotto.price}" type="number" maxFractionDigits="2" />€
			                        </span>
			                        <span class="discounted-price" style="color: green; font-weight: bold; margin-left: 10px;">
			                            <fmt:formatNumber value="${prezzoScontato}" type="number" maxFractionDigits="2" />€
			                        </span>
			                    </c:when>
			                    <c:otherwise>
			                        <fmt:formatNumber value="${prodotto.price}" type="number" maxFractionDigits="2" />€
			                    </c:otherwise>
			                </c:choose>
			            </div>
		
			            <c:if test="${prodotto.stocks == 0}">
			                <div class="not-available" style="color: orange; font-weight: bold;">
			                    Al momento non disponibile
			                </div>
			            </c:if>
					<c:if test="${sessionScope.ruolo != 1}">
			            <c:if test="${prodotto.stocks > 0}">
			                <div class="quantity-selector">
			                    <label for="quantity">Quantità:</label>
			                    <button type="button" onclick="changeQty(-1)">−</button>
			                    <input type="number" id="quantity" name="quantity" value="1" min="1" max="${prodotto.stocks}">
			                    <button type="button" onclick="changeQty(1)">+</button>
			                </div>
			
			                <div class="action-buttons">
			                    <button type="button" class="wishlist" onclick="addToList(${prodotto.id}, 'wishlist', 1)">
			                        <i class="fa-regular fa-heart"></i> Wishlist
			                    </button>
			
			                    <button type="button" class="add-to-cart"   onclick="addToList(${prodotto.id}, 'cart', document.getElementById('quantity').value)">
			                        <i class="fa-solid fa-cart-shopping"></i> Aggiungi al carrello
			                    </button>
			                </div>
			            </c:if>
			         </c:if>
	        		</c:otherwise>
    			</c:choose>
			</div>
        </div>
        
        <br><br><br>
        
        <h2 id="sezioneRecensioni">Recensioni</h2> <br><br><br>
        <div id="review-wrapper">
        	
			    
			    <c:set var="hasReviewed" value="false" />

				<c:forEach var="entry" items="${recensioni}">
				    <c:set var="review" value="${entry.key}" />
				    <c:if test="${review.id_user == userId}">
				        <c:set var="hasReviewed" value="true" />
				    </c:if>
				</c:forEach>
				<c:if test="${sessionScope.ruolo != 1}">
				<c:if test="${not hasReviewed}">
				    <div id="write-review-panel">
				        <h3>Scrivi una recensione</h3>
				        <p>Hai provato questo prodotto? Lascia la tua opinione!</p>
				        <a href="${pageContext.request.contextPath}/user/WriteReview.jsp?productId=${prodotto.id}">
				            <button>Scrivi recensione</button>
				        </a>
				    </div>
				</c:if>
				</c:if>
				 
			    
			    <div id="reviews-panel">
				    <c:choose>
				        <c:when test="${empty recensioni}">
				            <p>Nessuna recensione per questo prodotto.</p>
				        </c:when>
				        <c:otherwise>
				            <c:forEach var="entry" items="${recensioni}">
				                <c:set var="review" value="${entry.key}" />
				                <c:set var="user" value="${entry.value}" />
				
				                <c:if test="${review.id_user == userId}">
				                    <div id="reviews-data-panel">
				                        <div id="reviews-data">
				                        	<span>(La tua recensione)</span><br>
				                            <span class="stars">
				                                <c:forEach begin="1" end="5" var="i">
				                                    <i class="fa-star <c:out value='${i <= review.vote ? "fas" : "far"}'/>"></i>
				                                </c:forEach>
				                            </span>
				                            <span>${user.name}</span>
				                        </div>
				
				                        <span id="data">
				                            ${review.reviewDate.dayOfMonth}/${review.reviewDate.monthValue}/${review.reviewDate.year}
				                        </span>
				
				                        <p>${review.text}</p>
				                        
				                        <form action="${pageContext.request.contextPath}/user/DeleteReviewServlet" method="post" style="text-align: right;">
								            <input type="hidden" name="productId" value="${prodotto.id}" />
								            <button type="submit" title="Elimina recensione" style="background: none; border: none; cursor: pointer;">
								                <i class="fa-solid fa-trash" style="color: red;"></i>
								            </button>
								        </form>
				                    </div>
				                </c:if>
				            </c:forEach>
				
				            <c:forEach var="entry" items="${recensioni}">
				                <c:set var="review" value="${entry.key}" />
				                <c:set var="user" value="${entry.value}" />
				
				                <c:if test="${review.id_user != userId}">
				                    <div id="reviews-data-panel">
				                        <div id="reviews-data">
				                            <span class="stars">
				                                <c:forEach begin="1" end="5" var="i">
				                                    <i class="fa-star <c:out value='${i <= review.vote ? "fas" : "far"}'/>"></i>
				                                </c:forEach>
				                            </span>
				                            <span>${user.name}</span>
				                        </div>
				
				                        <span id="data">
				                            ${review.reviewDate.dayOfMonth}/${review.reviewDate.monthValue}/${review.reviewDate.year}
				                        </span>
				
				                        <p>${review.text}</p>
				                    </div>
				                </c:if>
				            </c:forEach>
				        </c:otherwise>
				    </c:choose>
				</div>

			
        </div>
        
        
        <br><br><br>
        
        
    </main>

    <div id="toast" class="toast">Prodotto aggiunto!</div>

    <%@ include file="../common/footer.html" %>
</div>


<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>


<script src="../script/AJAX.js"></script>


<script>

window.EventListener("load", function () {
    const slides = document.querySelectorAll(".swiper-slide");
    const slideCount = slides.length;

    if (slideCount === 0) return; // Niente da inizializzare

    const swiper = new Swiper(".mySwiper", {
        loop: slideCount >= 3,
        allowTouchMove: slideCount > 1,
        navigation: slideCount > 1 ? {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev"
        } : false,
        pagination: {
            el: ".swiper-pagination",
            clickable: true
        },
        slidesPerView: 1,
        spaceBetween: 10
    });
});

function changeQty(delta) {
    const input = document.getElementById("quantity");
    let current = parseInt(input.value);
    const max = parseInt(input.max);
    if (isNaN(current)) current = 1;
    let newValue = Math.min(Math.max(1, current + delta), max);
    input.value = newValue;
}

function showToast(message, isError = false) {
    const toast = document.getElementById("toast");
    toast.textContent = message;

    toast.className = "toast show";

    if (isError) {
        toast.classList.add("error");
    } else {
        toast.classList.add("success");
    }

    setTimeout(() => {
        toast.className = "toast";
    }, 3000);
}


</script>

</body>
</html>
