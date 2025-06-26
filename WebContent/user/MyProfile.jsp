<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>



<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Profile</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/MyProfileStyle.css?v=<%= System.currentTimeMillis() %>">
   
    <script src="${pageContext.request.contextPath}/script/myProfileScript.js">
    
    </script>
</head>
<body>
<div class="page-wrapper">
    <%@ include file="/common/header.jsp" %>

    <div class="content">
        <h1>Benvenuto, ${user.name}!</h1>

        <div class="button-row">
            <button class="b" onclick="toggleSection('dati-personali')">Dati Personali</button>
            <button class="b" onclick="toggleSection('storico-ordini')">Storico Ordini</button>     
            
        </div>

        <div class="dati-personali" id="dati-personali" style="display:none;">
            <h2>Dati Personali</h2>
            <p><strong>Email:</strong> ${user.email}</p>
            <p><strong>Nome:</strong> ${user.name}</p>
            <p><strong>Cognome:</strong> ${user.surname}</p>
            <p><strong>Telefono:</strong> ${user.tel}</p>
            <p><strong>Indirizzo:</strong> ${user.via}, ${user.roadNum} - ${user.postalCode} - ${user.provincia}</p>

            <form class="update" action="UpdateAddressServlet" method="post">
                <h3>Aggiorna indirizzo</h3>
                <label for="ind">Via <input type="text" id="ind" name="ind" value="${user.via}" required></label><br>
                <label for="civ">Civico <input type="text" id="civ" name="civ" value="${user.roadNum}" required></label><br>
                <label for="cap">CAP <input type="text" id="cap" name="cap" value="${user.postalCode}" required></label><br>
                <label for="prov">Provincia <input type="text" id="prov" name="prov" value="${user.provincia}" required></label><br>
                <input type="submit" value="Aggiorna indirizzo">
            </form>
        </div>

        <div id="storico-ordini" style="display:none;">
            <h2>Storico Ordini</h2>

            <c:if test="${not empty ordini}">
                <c:forEach var="ordine" items="${ordini}">
                    <div class="ordine-box">
                        <details>
                            <form action="${pageContext.request.contextPath}/cancelOrder" method="post">
                                <input type="hidden" name="orderId" value="${ordine.id}" />
                                <c:if test="${ordine.status == 'In_elaborazione' || ordine.status == 'Elaborato'}">
                                    <p style="text-indent:1.5em">
                                        <button class="cancel" type="submit">Annulla Ordine</button>
                                    </p>
                                </c:if>
                            </form>

                            <summary>
                                <c:set var="stato" value="${fn:replace(ordine.status, '_', ' ')}" />
                                <c:set var="statoFormattato" value="${fn:toUpperCase(fn:substring(stato, 0, 1))}${fn:toLowerCase(fn:substring(stato, 1, fn:length(stato)))}" />
                               
                                <strong>Ordine #${ordine.id}</strong> <br>
                              	<p style="text-indent:1.1em"><strong>Indirizzo di spedizione </strong> ${ordine.via} , ${ordine.roadNum}  - ${ordine.postalCode} (${ordine.provincia})   </p>                
                                <p style="text-indent:1.1em">Stato: ${statoFormattato}<br></p>
                                <p style="text-indent:1.1em">  Pagato il: ${billsMap[ordine.id] != null ? billsMap[ordine.id].billDate : 'N/A'}  </p>
                                <p style="text-indent:1.1em">Totale: 
                                    <c:choose>
                                        <c:when test="${billsMap[ordine.id] != null}">
                                            <fmt:formatNumber value="${billsMap[ordine.id].total}" type="currency" currencySymbol="€" maxFractionDigits="2" />
                                        </c:when>
                                        <c:otherwise>€0.00</c:otherwise>
                                    </c:choose>
                                </p>
                            </summary>

                            <c:set var="productsOrder" value="${prodottiPerOrdine[ordine.id]}" />
                            <c:forEach var="pr" items="${productsOrder}">
                                <c:set var="product" value="${prodotti[pr.id_product]}" />
                                 <c:set var="coverImage" value="${coverImages[product.id]}" />
                                <div class="product-item">
                                    <c:choose>
			                            <c:when test="${not empty coverImage}">
			                                <img src="${pageContext.request.contextPath}/image?id=${coverImage.id}" alt="Immagine di copertina" />
			                            </c:when>
			                            <c:otherwise>
			                                <img src="img/default.jpg" alt="Nessuna immagine disponibile" />
			                            </c:otherwise>
			                        </c:choose>
			
                                    <div class="product-info">
                                        <p><strong>Nome:
                                            <a href="${pageContext.request.contextPath}/common/productDetails?id=${product.id}" style="text-decoration: none; color: #000000; font-size: 1.1em;">
                                                ${product.name}
                                            </a>
                                        </strong></p>
                                        <p><strong>ID:</strong> ${pr.id_product}</p>
                                        <p><strong>Prezzo:</strong> €${pr.price}</p>
                                        <p><strong>Quantità:</strong> ${pr.quantity}</p>
										<p><strong>Totale prodotto:</strong> 
										    <fmt:formatNumber value="${pr.price * pr.quantity}" type="number" maxFractionDigits="2" minFractionDigits="2" /> €
										</p>

 									<c:if test="${ordine.status == 'Consegnato'}">
	                                    <form action="WriteReview.jsp" method="get" style="margin-top: 10px;"> <!-- ${pageContext.request.contextPath}/reviewProduct --> 
		    								<input type="hidden" name="productId" value="${pr.id_product}" />
	 									   	<c:if test="${not fn:contains(prodottiRecensiti, pr.id_product)}">
												<button type="submit" class="review">Lascia una recensione</button>
											</c:if>
	 									  
										</form>
                                 <!-- ELSE: prodotto GIÀ recensito -->
									<c:if test="${fn:contains(prodottiRecensiti, pr.id_product)}">
									    <form action="DeleteReviewServlet" method="post" style="margin-top: 10px;">
									        <input type="hidden" name="productId" value="${pr.id_product}" />
									        <button type="submit" class="delRev">Elimina recensione</button>
									    </form>
									</c:if>
									</c:if>
                                    </div>
                                </div>
                            </c:forEach>
                        </details>
                    </div>
                </c:forEach>
            </c:if>
        </div>
    </div>

    <%@ include file="/common/footer.jsp" %>
</div>
</body>
</html>
