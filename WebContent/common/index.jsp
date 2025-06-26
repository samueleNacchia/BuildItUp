<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
	<title>BuildItUp</title>
	<style>html{display:none}</style>
	
	
	<%@ include file="header.jsp" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_index.css?v=<%= System.currentTimeMillis() %>">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    

</head>
<body>
	<div class="page-wrapper">
	    <main class="homepage">
			<div id="discounts">
				<h1>Discounts</h1>
			   	<c:if test="${not empty scontati}">
			        <div class="products">
			            <c:forEach var="product" items="${scontati}">
			                <c:set var="coverImage" value="${coverImages[product.id]}" />
			                <a href="${pageContext.request.contextPath}/common/productDetails?id=${product.id}" class="product-link">
			                    <div class="product-card">

			                        <c:choose>
			                            <c:when test="${not empty coverImage}">
			                                <img src="${pageContext.request.contextPath}/image?id=${coverImage.id}" alt="Immagine di copertina" />
			                            </c:when>
			                            <c:otherwise>
			                                <img src="img/default.jpg" alt="Nessuna immagine disponibile" />
			                            </c:otherwise>
			                        </c:choose>
			                        <c:if test="${product.numReview >= 0}">
						    			<span class="stars">
						    				
						    				<span id="avgN">${product.avgReview}</span>
						    				
							    			<c:forEach var="i" begin="1" end="5">
											    <c:choose>
											        <c:when test="${i <= product.avgReview}">
											            <i class="fas fa-star"></i>
											        </c:when>
											        <c:when test="${i - 0.5 == product.avgReview}">
											            <i class="fas fa-star-half-alt"></i>
											        </c:when>
											        <c:otherwise>
											            <i class="far fa-star"></i>
											        </c:otherwise>
											    </c:choose>
											</c:forEach>
						
											(${product.numReview})
										</span>
					    			</c:if>
			
			                        <h3 class="product-title">${product.name}</h3>
			
			                        <div class="product-price">
			                            <c:choose>
			                                <c:when test="${product.discount > 0}">
			                                	<c:set var="prezzoScontato" value="${product.price * (1 - product.discount)}" />
			                                    
			                                    <span class="original-price">
			                                        <fmt:formatNumber value="${product.price}" type="number" maxFractionDigits="2" />€
			                                    </span>
			                                    <span class="discounted-price">
			                                        <fmt:formatNumber value="${prezzoScontato}" type="number" maxFractionDigits="2" />€
			                                    </span>
			                                    <span class="discount-percentage">
			                                        -<fmt:formatNumber value="${product.discount * 100}" maxFractionDigits="0" />%
			                                    </span>
			                                </c:when>
			                                <c:otherwise>
			                                    <span class="price">
			                                        <fmt:formatNumber value="${product.price}" type="number" maxFractionDigits="2" />€
			                                    </span>
			                                </c:otherwise>
			                            </c:choose>
			                        </div>
			                    </div>
			                </a>
			            </c:forEach>
			        </div>
				    <div class="view-all">
				    	<a class="out" href="CatalogViewer?type=discounts">View All</a>
				    </div>
			    </c:if>
			    <c:if test="${empty scontati}">
			   		<span class="msgNotFound">Ancora nessun prodotto in sconto</span>
				</c:if>
			</div>
			
			
			
			
			<div id="bestsellers">
			   	<h1>Best Sellers</h1>
			  	<c:if test="${not empty bestsellers}">
			        <div class="products">
			            <c:forEach var="product" items="${bestsellers}">
			                <c:set var="coverImage" value="${coverImages[product.id]}" />
			                <a href="${pageContext.request.contextPath}/common/productDetails?id=${product.id}" class="product-link">
			                    <div class="product-card">

			                        <c:choose>
			                            <c:when test="${not empty coverImage}">
			                                <img src="${pageContext.request.contextPath}/image?id=${coverImage.id}" alt="Immagine di copertina" />
			                            </c:when>
			                            <c:otherwise>
			                                <img src="img/default.jpg" alt="Nessuna immagine disponibile" />
			                            </c:otherwise>
			                        </c:choose>
			                        <c:if test="${product.numReview >= 0}">
						    			<span class="stars">
						    				
						    				<span id="avgN">${product.avgReview}</span>
						    				
							    			<c:forEach var="i" begin="1" end="5">
											    <c:choose>
											        <c:when test="${i <= product.avgReview}">
											            <i class="fas fa-star"></i>
											        </c:when>
											        <c:when test="${i - 0.5 == product.avgReview}">
											            <i class="fas fa-star-half-alt"></i>
											        </c:when>
											        <c:otherwise>
											            <i class="far fa-star"></i>
											        </c:otherwise>
											    </c:choose>
											</c:forEach>
						
											(${product.numReview})
										</span>
					    			</c:if>
			
			                        <h3 class="product-title">${product.name}</h3>
			
			                        <div class="product-price">
			                            <c:choose>
			                                <c:when test="${product.discount > 0}">
			                                	<c:set var="prezzoScontato" value="${product.price * (1 - product.discount)}" />
			                                    
			                                    <span class="original-price">
			                                        <fmt:formatNumber value="${product.price}" type="number" maxFractionDigits="2" />€
			                                    </span>
			                                    <span class="discounted-price">
			                                        <fmt:formatNumber value="${prezzoScontato}" type="number" maxFractionDigits="2" />€
			                                    </span>
			                                    <span class="discount-percentage">
			                                        -<fmt:formatNumber value="${product.discount * 100}" maxFractionDigits="0" />%
			                                    </span>
			                                </c:when>
			                                <c:otherwise>
			                                    <span class="price">
			                                        <fmt:formatNumber value="${product.price}" type="number" maxFractionDigits="2" />€
			                                    </span>
			                                </c:otherwise>
			                            </c:choose>
			                        </div>
			                    </div>
			                </a>
			            </c:forEach>
			        </div>
			        <div class="view-all">
			            <a class="out" href="CatalogViewer?type=bestsellers">View All</a>
			        </div>
			  	</c:if>
			    <c:if test="${empty bestsellers}">
			   		<p class="msgNotFound">Ancora nessun bestseller</p>
				</c:if>
			</div>
				
	    </main>
	  
	    <div id="newsletter">
	        <form method="POST" action="${pageContext.request.contextPath}/common/SignToNewsletter">
	            <label for="email">Email:</label>
			    <input type="email" id="email" name="email" placeholder="example@gmail.com" required>
			    <span id="emailError" class="error-msg"></span>
	            <input type="submit">
	        </form>
	    </div>
	</div>
	
	<%@ include file="footer.jsp" %>
	<script src="${pageContext.request.contextPath}/script/indexScript.js"></script>
	<script src="${pageContext.request.contextPath}/script/logInScript.js"></script>
</body>
</html>