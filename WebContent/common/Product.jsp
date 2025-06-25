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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_product.css?v=<%= System.currentTimeMillis() %>">

</head>
<body data-context-path="${pageContext.request.contextPath}">
<div class="page-wrapper">
    <%@ include file="header.jsp" %>

    <main class="homepage">

        <div class="product-wrapper">

			<c:choose>
			  <c:when test="${empty immagini}">
			    <div class="swiper-placeholder">
			      <p>Immagini non disponibili</p>
			    </div>
			  </c:when>
			  
			  <c:otherwise>
			    <div class="swiper mySwiper">
			      <div class="swiper-wrapper">
			        <c:forEach var="image" items="${immagini}">
			          <c:if test="${image.isCover}">
			            <div class="swiper-slide">
			              <img src="${pageContext.request.contextPath}/image?id=${image.id}"/>
			            </div>
			          </c:if>
			        </c:forEach>
			        <c:forEach var="image" items="${immagini}">
			          <c:if test="${!image.isCover}">
			            <div class="swiper-slide">
			              <img src="${pageContext.request.contextPath}/image?id=${image.id}"/>
			            </div>
			          </c:if>
			        </c:forEach>
			      </div>
			
			      <div class="swiper-button-next"></div>
			      <div class="swiper-button-prev"></div>
			      <div class="swiper-pagination"></div>
			    </div>
			  </c:otherwise>
			  
			</c:choose>



            <div class="product-details">
    			<h1 class="product-title">${prodotto.name}</h1>
    			
    			<c:if test="${prodotto.numReview > 0}">
	    			<span class="stars">
	    				
	    				<span id="avgN">${prodotto.avgReview}</span>
	    				
		    			<c:forEach var="i" begin="1" end="5">
						    <c:choose>
						        <c:when test="${i <= prodotto.avgReview}">
						            <i class="fas fa-star"></i> <!-- stella piena -->
						        </c:when>
						        <c:when test="${i - 0.5 == prodotto.avgReview}">
						            <i class="fas fa-star-half-alt"></i> <!-- mezza stella -->
						        </c:when>
						        <c:otherwise>
						            <i class="far fa-star"></i> <!-- stella vuota -->
						        </c:otherwise>
						    </c:choose>
						</c:forEach>
	
						(${prodotto.numReview})
					</span>
    			</c:if>
    			<p class="product-description">${prodotto.description}</p>

	    		<c:choose>
	        		<c:when test="${not prodotto.onSale}">
			            <div class="notavlb">
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
			                        <span id="original-price">
			                            <fmt:formatNumber value="${prodotto.price}" type="number" maxFractionDigits="2" />€
			                        </span>
			                        <span id="discounted-price">
			                            <fmt:formatNumber value="${prezzoScontato}" type="number" maxFractionDigits="2" />€
			                        </span>
			                    </c:when>
			                    <c:otherwise>
			                        <fmt:formatNumber value="${prodotto.price}" type="number" maxFractionDigits="2" />€
			                    </c:otherwise>
			                </c:choose>
			            </div>
		
			            <c:if test="${prodotto.stocks == 0}">
			                <div class="notavlb">
			                    Al momento non disponibile
			                </div>
			                <div class="action-buttons">
			                    <button type="button" class="wishlist" onclick="addToList(${prodotto.id}, 'wishlist', 1)">
			                        <i class="fa-regular fa-heart"></i> Wishlist
			                    </button>
			                </div>
			            </c:if>
					<c:if test="${sessionScope.ruolo != true}">
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
				<c:if test="${sessionScope.ruolo != true}">
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
				                    
				                    	<c:if test="${review.isVerified}">
										    <span class="review-type">✔ Recensione verificata</span>
										    <br><br>
										</c:if>
										
										
										
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
								            <button type="submit" title="Elimina recensione" id="delreview">
								                <i class="fa-solid fa-trash" style="color: red"></i>
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
				                    
				                    	<c:if test="${review.isVerified}">
										    <span class="review-type">✔ Recensione verificata</span>
										    <br><br>
										</c:if>
										
										
														                    	
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

    <%@ include file="footer.jsp" %>
</div>


<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>


<script src="${pageContext.request.contextPath}/script/AJAX.js?v=<%= System.currentTimeMillis() %>"></script>


<script src="${pageContext.request.contextPath}/script/productScript.js"></script>

</body>
</html>
