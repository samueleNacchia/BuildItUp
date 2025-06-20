<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>



<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Profile</title>
    <link rel="stylesheet" type="text/css" href="../css/MyProfileStyle.css">
    <link rel="stylesheet" href="../css/style_header.css">
    <link rel="stylesheet" href="../css/style_footer.css">

    <script>
        function toggleSection(id) {
            const section = document.getElementById(id);
            section.style.display = (section.style.display === "none") ? "block" : "none";
            if (section === document.getElementById("dati-personali"))
                document.getElementById("storico-ordini").style.display = "none";
            else if (section === document.getElementById("storico-ordini"))
                document.getElementById("dati-personali").style.display = "none";
        }

        function hideSections() {
            document.getElementById("dati-personali").style.display = "none";
            document.getElementById("storico-ordini").style.display = "none";
        }
    </script>
</head>
<body>
<div class="page-wrapper">
    <%@ include file="/header.html" %>

    <div class="content">
        <h1>Benvenuto, ${user.name}!</h1>

        <div class="button-row">
            <button class="b" onclick="toggleSection('dati-personali')">Dati Personali</button>
            <button class="b" onclick="toggleSection('storico-ordini')">Storico Ordini</button>
           <a href="${pageContext.request.contextPath}/logout"> <button class="b">Log Out</button> </a>
            <button class="b" onclick="hideSections()">Nascondi</button>
            
            
        </div>

        <div class="dati-personali" id="dati-personali" style="display:none;">
            <h2>Dati Personali</h2>
            <p><strong>Email:</strong> ${user.email}</p>
            <p><strong>Nome:</strong> ${user.name}</p>
            <p><strong>Cognome:</strong> ${user.surname}</p>
            <p><strong>Telefono:</strong> ${user.tel}</p>
            <p><strong>Indirizzo:</strong> ${user.via}, ${user.roadNum} - ${user.postalCode} - ${user.provincia}</p>

            <form class="update" action="../UpdateAddressServlet" method="post">
                <h3>Aggiorna indirizzo</h3>
                <input type="text" name="ind" value="${user.via}" required><br>
                <input type="text" name="civ" value="${user.roadNum}" required><br>
                <input type="text" name="cap" value="${user.postalCode}" required><br>
                <input type="text" name="prov" value="${user.provincia}" required><br>
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
                                <strong>Ordine #${ordine.id}</strong> 
                                Stato: ${statoFormattato}<br>
                                <p style="text-indent:1.1em">
                                    Pagato il: ${billsMap[ordine.id] != null ? billsMap[ordine.id].billDate : 'N/A'} - 
                                    Totale: 
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
                                <div class="product-item">
                                    <img class="product-image"
                                         src="ViewImage?id=${pr.id_product}"
                                         alt="${product.name}"
                                         width="100" height="100" />
                                    <div class="product-info">
                                        <p><strong>Nome:
                                            <a href="${pageContext.request.contextPath}/productDetails?id=${product.id}" style="text-decoration: none; color: #000000; font-size: 1.1em;">
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
									    <form action="${pageContext.request.contextPath}/DeleteReviewServlet" method="post" style="margin-top: 10px;">
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

    <%@ include file="../footer.html" %>
</div>
</body>
</html>-
