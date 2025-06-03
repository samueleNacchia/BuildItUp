<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Conferma Ordine</title>
    <%@ include file="header.html" %>
    <link rel="stylesheet" href="css/StyleView.css?v=<%= System.currentTimeMillis() %>">
</head>
<body>
    <div class="page-wrapper">
        <main class="homepage">
            <div class="container">

                <c:choose>
                    <c:when test="${not empty ordine and not empty fattura and not empty data}">
                        <h1 style="color:green">Ordine Confermato!</h1>

                        <div class="order-info">
                            <p><strong>Numero Ordine:</strong> ${ordine.id}</p>
                            <p><strong>ID Utente:</strong> ${ordine.id_user}</p>
                            <p><strong>Totale:</strong> 
                                <fmt:formatNumber value="${fattura.total}" type="currency" currencySymbol="€" maxFractionDigits="2" />     
                            </p>
                            <p><strong>Data Ordine:</strong>${data}</p>
                            <p><strong>Stato:</strong> ${ordine.status}</p>
                        </div>

                        <div class="back-link">
                            <a href="Home">Torna alla home</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <h1 style="color:red;">Ordine Fallito!</h1>
                        <a href="Home" style="color:red;">Torna alla home</a>
                    </c:otherwise>
                </c:choose>

            </div>
        </main>
       	<%@ include file="footer.html" %> 
    </div>
</body>
</html>