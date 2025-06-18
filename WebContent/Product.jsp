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
<link rel="stylesheet" href="./css/style_header.css?v=<%= System.currentTimeMillis() %>">
<link rel="stylesheet" href="./css/style_footer.css?v=<%= System.currentTimeMillis() %>">
<link rel="stylesheet" href="./css/style_product.css?v=<%= System.currentTimeMillis() %>">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />



</head>
<body>
<div class="page-wrapper">
    <%@ include file="header.html" %>

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

                    <button type="button" class="add-to-cart" onclick="addToList(${prodotto.id}, 'cart', document.getElementById('quantity').value)">
                        <i class="fa-solid fa-cart-shopping"></i> Aggiungi al carrello
                    </button>
                </div>
            </c:if>
        </c:otherwise>
    </c:choose>
</div>

        </div>
    </main>

    <div id="toast" class="toast">Prodotto aggiunto!</div>

    <%@ include file="footer.html" %>
</div>


<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>


<script src="script/AJAX.js"></script>


<script>

window.addEventListener("load", function () {
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
