<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>
        <c:set var="type" value="${param.type}" />
        <c:choose>
            <c:when test="${type == 'wishlist'}">
                <c:set var="titolo" value="Wishlist" />
            </c:when>
            <c:when test="${type == 'cart'}">
                <c:set var="titolo" value="Carrello" />
            </c:when>
            <c:otherwise>
                <c:set var="titolo" value="Lista" />
            </c:otherwise>
        </c:choose>
        ${titolo}
    </title>
    <style>html{display:none}</style>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/StyleView.css?v=<%= System.currentTimeMillis() %>">  
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    
</head>

<body data-context-path="${pageContext.request.contextPath}">

	<div class="page-wrapper">
			<%@ include file="/common/header.jsp" %>
			<main>
		    <h1>${titolo}</h1>
		
		    <c:if test="${not empty type}">
		        <c:choose>
		            <c:when test="${empty items}">
		                <p id="empty-message">
		                    <c:choose>
		                        <c:when test="${type == 'wishlist'}">
		                            La wishlist è vuota
		                        </c:when>
		                        <c:when test="${type == 'cart'}">
		                            Il carrello è vuoto
		                        </c:when>
		                        <c:otherwise>
		                            La lista è vuota
		                        </c:otherwise>
		                    </c:choose>
		                </p>
		            </c:when>
		            <c:otherwise>
		                <table id="product-table">
		                    
		                    <c:forEach var="item" items="${items}">
		                        <c:set var="product" value="${item.product}" />
		                        
		                        <tr id="product-${product.id}">
		                            <td data-label="Nome">${product.name}</td>
		                            <td data-label="Prezzo"><fmt:formatNumber value="${product.price * (1-product.discount)}" maxFractionDigits="2" />€</td>
		                            <td><img src="<%= request.getContextPath() %>/image?cover=true&id=${product.id}" alt="Immagine ${product.name}" /></td>
		
		                            <c:if test="${type == 'cart'}">
		                                <td data-label="Quantità" id="quantity-${product.id}">${item.quantity}</td>
		                            </c:if>
		
		                            <td>
		                                <c:if test="${type == 'cart'}">
		                                    <button id="btn-add-${product.id}" class="add" onclick="addItem(${product.id}, 'cart')">+</button>
		                                </c:if>
										<c:if test="${type == 'wishlist'}">
		                                    <button id="btn-add-${product.id}" class="add" onclick="addItem(${product.id}, 'cart')">Aggiungi al carrello</button>
		                                </c:if>
									
		                                <button id="btn-delete-${product.id}" class="delete" onclick="deleteItem(${product.id}, '${type}')">
		                                    <c:choose>
		                                        <c:when test="${item.quantity <= 1}"> X </c:when>
		                                        <c:otherwise> - </c:otherwise>
		                                    </c:choose>
		                                </button>
		                            </td>
		                        </tr>
		                    </c:forEach>
		                </table>
		                
		                <c:if test="${type == 'cart'}">
		                	<div style="text-align: center; margin-top: 20px; transform: scale(1.5)">
			            		<a id="btn-checkout" href="<%= request.getContextPath()%>/unlogged/GetList?type=cart&to=checkout" style="text-decoration: none;">
			                		<input class="btn" type="submit" class="update" value="Acquista" />
			            		</a>
		            		</div>
		       			</c:if>
		       			
		            </c:otherwise>
		        </c:choose>
		        
		        <br><br>
		
		        <p id="empty-message" style="display: none;">
		            <c:choose>
		                <c:when test="${type == 'wishlist'}">
		                    La wishlist è vuota
		                </c:when>
		                <c:when test="${type == 'cart'}">
		                    Il carrello è vuoto
		                </c:when>
		                <c:otherwise>
		                    La lista è vuota
		                </c:otherwise>
		            </c:choose>
		        </p>
		       
		        <script src="<%= request.getContextPath() %>/script/AJAX.js?v=<%= System.currentTimeMillis() %>"></script>
		    </c:if>
		     
		</main>
	</div>
	<%@ include file="/common/footer.jsp" %>
	<script src="<%= request.getContextPath()%>/script/indexScript.js">
	 </script>
</body>
</html>