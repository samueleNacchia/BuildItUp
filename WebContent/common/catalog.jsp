<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>BuildItUp</title>
    <style>html{display:none}</style>
    <%@ include file="header.jsp" %>
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.7.1/nouislider.min.css" rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_catalog.css?v=<%= System.currentTimeMillis() %>">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.7.1/nouislider.min.js"></script>
    
</head>

<body>
    <div class="page-wrapper">

		
        <main class="homepage">

            <div class="catalog-layout">

            <br><br>

				<button class="filter-toggle-btn">Filtri</button>
				

                <section class="filter-bar-horizontal">

                    <form method="POST" action="CatalogViewer" class="filter-form-horizontal">
                        
                       <label for="price-slider">Prezzo:  &nbsp;&nbsp;</label>
						<div id="price-slider"
						     data-min="${minPrice}" 
						     data-max="${maxPrice}">
						</div>
						
						<div id="price-values" style=""></div>

						
						<input type="hidden" name="minPrice" id="minPrice" value="${minPrice}">
						<input type="hidden" name="maxPrice" id="maxPrice" value="${empty maxPrice ? '' : maxPrice}">
						

                        Categoria
                        <select name="category" id="category">
                            <option value="" <c:if test="${empty category}">selected</c:if>>Tutte le categorie</option>
                            <option value="CPU" <c:if test="${category == 'CPU'}">selected</c:if>>CPU</option>
                            <option value="GPU" <c:if test="${category == 'GPU'}">selected</c:if>>GPU</option>
                            <option value="MOBO" <c:if test="${category == 'MOBO'}">selected</c:if>>MOBO</option>
                            <option value="CASE" <c:if test="${category == 'CASE'}">selected</c:if>>CASE</option>
                            <option value="COOLING" <c:if test="${category == 'COOLING'}">selected</c:if>>COOLING</option>
                            <option value="RAM" <c:if test="${category == 'RAM'}">selected</c:if>>RAM</option>
                            <option value="MEM" <c:if test="${category == 'MEM'}">selected</c:if>>MEM</option>
                            <option value="PSU" <c:if test="${category == 'PSU'}">selected</c:if>>PSU</option>
                        </select>

						Ordina
                        <select name="order" id="order">
                            <option value="" <c:if test="${empty category}">selected</c:if>>Rilevanza</option>
                            <option value="priceASC" <c:if test="${order == 'priceASC'}">selected</c:if>>Prezzo crescente</option>
                            <option value="priceDESC" <c:if test="${order == 'priceDESC'}">selected</c:if>>Prezzo decrescente</option>
                            <option value="avgRate" <c:if test="${order == 'avgRate'}">selected</c:if>>Media recensioni</option>
                        </select>
						
	
                        <label>
                            <input type="radio" name="type" value="discounts" <c:if test="${type == 'discounts'}">checked</c:if>>
                            In sconto
                        </label>

                        <label>
                            <input type="radio" name="type" value="bestsellers" <c:if test="${type == 'bestsellers'}">checked</c:if>>
                            Best Sellers
                        </label>

                        <button type="button" onclick="document.querySelectorAll('input[name=type]').forEach(el => el.checked = false)">Deseleziona</button>
                        <button type="submit">Filtra</button>
                    </form>

                </section>

                <c:if test="${not empty prodotti}">
				    <div class="products">
				        <c:forEach var="product" items="${prodotti}">
				            <c:set var="coverImage" value="${coverImages[product.id]}" />
				
				            <a href="${pageContext.request.contextPath}/common/productDetails?id=${product.id}" class="product-link">
				                <div class="product-card">
				                    <c:choose>
				                        <c:when test="${not empty coverImage}">
				                            <img src="${pageContext.request.contextPath}/image?id=${coverImage.id}" alt="Immagine di copertina" />
				                        </c:when>
				                        <c:otherwise>
				                            <img src="${pageContext.request.contextPath}/img/default.jpg" alt="Nessuna immagine disponibile" />
				                        </c:otherwise>
				                    </c:choose>
				
				                    <h3>${product.name}</h3>
				
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
				                                    <fmt:formatNumber value="${product.discount * 100}" maxFractionDigits="0" />%
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
				</c:if>
				
				<c:if test="${empty prodotti}">
					<span id="msgNotFound">Nessuna prodotto torvato</span>
				</c:if>
				
                <div id="pagination">
                    <c:if test="${totalPages > 1}">
                        <c:forEach var="i" begin="1" end="${totalPages}">
							<c:url var="link" value="CatalogViewer">
						  	<c:param name="page" value="${i}" />
						    <c:if test="${not empty type}">
						    	<c:param name="type" value="${type}" />
						    </c:if>
						    <c:if test="${not empty category}">
						    	<c:param name="category" value="${category}" />
						    </c:if>
						    <c:if test="${not empty minPrice}">
						    	<c:param name="minPrice" value="${minPrice}" />
						    </c:if>
						    <c:if test="${not empty maxPrice}">
						    	<c:param name="maxPrice" value="${maxPrice}" />
						    </c:if>
						    <c:if test="${not empty name}">
						      	<c:param name="name" value="${name}" />
						    </c:if>
						    <c:if test="${not empty order}">
						      	<c:param name="order" value="${order}" />
						    </c:if>
						    
						  	</c:url>
						
						  	<c:set var="active" value="" />
						  	<c:if test="${i == currentPage}">
						    	<c:set var="active" value="active" />
						  	</c:if>
						
						  	<a href="${link}" class="${active}">${i}</a>
						</c:forEach>
                    </c:if>
                </div>

            </div>
        </main>    
    </div>
	<%@ include file="footer.jsp" %>
    
<script src="${pageContext.request.contextPath}/script/catalogScript.js?v=<%= System.currentTimeMillis() %>"></script>

</body>
</html>