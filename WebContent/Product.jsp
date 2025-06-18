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



</head>
<body>
<div class="page-wrapper">
    <%@ include file="header.html" %>

    <main class="homepage">
        <div class="product-wrapper">

            <!-- CAROUSEL -->
            <div class="carousel">
			    <div class="carousel-images" id="carouselImages">
			        <!-- Immagine di copertina -->
			        <c:forEach var="img" items="${immagini}">
			            <c:if test="${img.cover}">
			                <img src="image?id=${img.id}" alt="Copertina" />
			            </c:if>
			        </c:forEach>
			
			        <!-- Tutte le altre -->
			        <c:forEach var="img" items="${immagini}">
			            <c:if test="${not img.cover}">
			                <img src="image?id=${img.id}" alt="Immagine prodotto" />
			            </c:if>
			        </c:forEach>
			    </div>
		
			    <!-- Bottoni -->
			    <button class="carousel-button prev" id="prevImage">‹</button>
			    <button class="carousel-button next" id="nextImage">›</button>
			</div>


            <!-- DETTAGLI -->
            <div class="product-details">
                <h1 class="product-title">${prodotto.name}</h1>
                <p class="product-description">${prodotto.description}</p>

                <c:set var="prezzoScontato" value="${prodotto.price}" />
                <c:if test="${prodotto.discount > 0}">
                    <c:set var="prezzoScontato" value="${prodotto.price * (1 - prodotto.discount)}" />
                </c:if>

                <c:choose>
                    <c:when test="${prodotto.discount > 0}">
                        <div class="product-price">
                            <span class="original-price" style="text-decoration: line-through; color: red;">
                                <fmt:formatNumber value="${prodotto.price}" type="number" maxFractionDigits="2" />€
                            </span>
                            <span class="discounted-price" style="color: green; font-weight: bold; margin-left: 10px;">
                                <fmt:formatNumber value="${prezzoScontato}" type="number" maxFractionDigits="2" />€
                            </span>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="product-price">
                            <fmt:formatNumber value="${prodotto.price}" type="number" maxFractionDigits="2" />€
                        </div>
                    </c:otherwise>
                </c:choose>

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
            </div>
        </div>
    </main>

    <div id="toast" class="toast">Prodotto aggiunto!</div>

    <%@ include file="footer.html" %>
</div>


<script src="script/AJAX.js"></script>


<script>

window.onload = function () {
    initCarousel();
};


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

function initCarousel() {
    const container = document.getElementById("carouselImages");
    const images = container.querySelectorAll("img");
    const total = images.length;

    if (total === 0) return;

    let current = 0;

    // Imposta la larghezza totale del contenitore: 100% per ogni immagine
    container.style.width = `${100 * total}%`;
    container.style.display = "flex";
    container.style.overflow = "hidden"; // opzionale


    // Ogni immagine prende la larghezza relativa al totale
    images.forEach(img => {
	    img.style.flex = "0 0 100%";
	    img.style.width = "100%";
	    img.style.maxWidth = "100%";
	    img.style.height = "400px"; // o quello che usi
	    img.style.objectFit = "contain";
	
    });


    function updateCarousel() {
        container.style.transform = `translateX(-${current * 100}%)`;
    }

    function nextImage() {
        current = (current + 1) % total;
        updateCarousel();
    }

    function prevImage() {
        current = (current - 1 + total) % total;
        updateCarousel();
    }

    document.getElementById("nextImage").addEventListener("click", nextImage);
    document.getElementById("prevImage").addEventListener("click", prevImage);

    updateCarousel(); // Mostra l'immagine iniziale
}


window.addEventListener("load", initCarousel);

	


</script>

</body>
</html>
