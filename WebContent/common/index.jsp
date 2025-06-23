<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
	<title>BuildItUp</title>
	<style>html{display:none}</style>
	
	
	 <%@ include file="header.jsp" %>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style_index.css?v=<%= System.currentTimeMillis() %>">
</head>
<body>
	<div class="page-wrapper">
	    <main class="homepage">
			<c:if test="${not empty scontati}">
	        
	            <div id="discounts">
	                <h1>Discounts</h1>
	                <div class="products">
	                
	                  	<c:forEach var="prodotto" items="${scontati}">
	                  	<a href="<%= request.getContextPath() %>/common/productDetails?id=${prodotto.id}" class="product-link">
						    <div class="product-card">
						        <c:set var="coverImage" value="${coverImages[prodotto.id]}" />
						
						        <c:choose>
						            <c:when test="${not empty coverImage}">
						                <img src="image?id=${coverImage.id}" alt="Immagine di copertina" />
						            </c:when>
						            <c:otherwise>
						                <img src="img/default.jpg" alt="Nessuna immagine disponibile" />
						            </c:otherwise>
						        </c:choose>
						
						        <h3>${prodotto.name}</h3>
						        <h3 class="discount">
						            <fmt:formatNumber value="${prodotto.discount * 100}" maxFractionDigits="2" />%
						        </h3>
						    </div>
						    </a>
						</c:forEach>	
							
	                </div>
	                <div class="view-all">
	                    <a class="out" href="CatalogViewer?type=discounts">View All</a>
	                </div>
	            </div>
	        </c:if>
	
	        <c:if test="${not empty bestsellers}">
	            <div id="bestsellers">
	                <h1>Best Sellers</h1>
	                <div class="products">
	                    <c:forEach var="prodotto" items="${bestsellers}">
	                    	<c:set var="coverImage" value="${coverImages[prodotto.id]}" />
	                    	<a href="productDetails?id=${prodotto.id}" class="product-link">
	    					<div class="product-card">
		        				<c:choose>
						            <c:when test="${not empty coverImage}">
						                <img src="<%= request.getContextPath() %>/image?id=${coverImage.id}" alt="Immagine di copertina" />
						            </c:when>
						            <c:otherwise>
						                <img src="img/default.jpg" alt="Nessuna immagine disponibile" />
						            </c:otherwise>
						        </c:choose>
		        				<h3>${prodotto.name}</h3>
		        				<h3>${prodotto.price}€</h3>
	    				</div>
	    				</a>
						</c:forEach>
	                </div>
	                <div class="view-all">
	                    <a class="out" href="CatalogViewer?type=bestsellers">View All</a>
	                </div>
	            </div>
	        </c:if>
	    </main>
	    
	    <a href="<%= request.getContextPath()%>/products" class="btn">Visualizza Database</a>
	  
	    <div id="newsletter">
	        <form method="POST" action="iscrizione">
	            <label for="email">Iscriviti alla newsletter</label>
	            <input type="email" id="email" name="email">
	            <input type="submit">
	        </form>
	    </div>
	</div>
	<%@ include file="footer.jsp" %>
	<script src="<%= request.getContextPath()%>/script/indexScript.js">
	 
	</script>
</body>
</html>