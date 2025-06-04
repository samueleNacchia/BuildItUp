<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Riepilogo Ordine</title>
    <style>html{display:none}</style>
    <%@ include file="header.html" %>
    <link rel="stylesheet" href="css/StyleView.css?v=<%= System.currentTimeMillis() %>">  
</head>
<body>
    <div class="page-wrapper">
        <a href="Home">Home</a>

        <main class="homepage">
            <h2>Riepilogo del tuo ordine</h2>

            <table>
                <tr>
                    <th>Prodotto</th>
                    <th>Quantità</th>
                    <th>Prezzo unitario</th>
                    <th>Subtotale</th>
                </tr>

                <c:set var="total" value="0" />

                <c:forEach var="item" items="${items}">
                    <c:set var="product" value="${item.product}" />
                    <c:set var="quantity" value="${item.quantity}" />
                    <c:set var="price" value="${product.price * (1 - product.discount)}" />
                    <c:set var="subtotal" value="${quantity * price}" />
                    <c:set var="total" value="${total + subtotal}" />

                    <tr>
                        <td>${product.name}</td>
                        <td>${quantity}</td>
                        <td>€ <fmt:formatNumber value="${price}" maxFractionDigits="2" /></td>
                        <td>€ <fmt:formatNumber value="${subtotal}" maxFractionDigits="2" /></td>
                    </tr>  
                </c:forEach>

                <tr class="totale">
                    <td colspan="3"><strong>Totale</strong></td>
                    <td><strong>€ <fmt:formatNumber value="${total}" maxFractionDigits="2" /></strong></td>
                </tr>
            </table>

            <form class="btn-form " action="SaveOrder" method="post">
                <input class="btn" type="submit" value="Conferma Ordine">
            </form>
        </main>
    </div>   
    <%@ include file="footer.html" %>
	<script>
	  window.addEventListener("load", function() {
	    document.documentElement.style.display = "block";
	  });
	</script>
</body>
</html>