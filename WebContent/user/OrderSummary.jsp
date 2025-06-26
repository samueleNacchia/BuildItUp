<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Conferma Ordine</title>
    <style>html{display:none}</style>
    <%@ include file="/common/header.jsp" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_summary.css">
</head>
<body>
    <div class="page-wrapper">
        <main class="homepage">
            <div class="container">

                <c:choose>
                    <c:when test="${not empty ordine and not empty fattura}">
                        <h1 class="success-titl">Ordine Confermato!</h1>

                        <div class="order-info">
                            <p><strong>Totale: </strong>${fattura.total} €</p>
                            <p><strong>Data Ordine: </strong>${ordine.orderDateFormatted}</p>
                            <p><strong>Indirizzo di spedizione </strong> ${ordine.via} , ${ordine.roadNum}  - ${ordine.postalCode} (${ordine.provincia})   </p>                       
                        </div>
                        
						<a class="link-green" href="${pageContext.request.contextPath}/common/Home">Torna alla home</a>
                        
                    </c:when>
                    <c:otherwise>
                        <h1 class="error-titl">Ordine Fallito!</h1>
                        <a class="link-red" href="${pageContext.request.contextPath}/common/Home" style="color:red;">Torna alla home</a>
                    </c:otherwise>
                </c:choose>

            </div>
        </main>
    </div>
    <%@ include file="/common/footer.jsp" %> 
    <script src="${pageContext.request.contextPath}/script/indexScript.js">
</script>
</body>
</html>