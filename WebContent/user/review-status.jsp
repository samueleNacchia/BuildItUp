<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Stato recensione</title>
    <meta http-equiv="refresh" content="3;URL=${pageContext.request.contextPath}/common/productDetails?id=${param.id}">
    <style>
        body {
            font-family: sans-serif;
            background-color: #f5f5f5;
            text-align: center;
            margin-top: 100px;
        }
        .message-box {
            display: inline-block;
            padding: 2em;
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
            border-radius: 5px;
            font-size: 1.2em;
        }
        .message-box.error {
            background-color: #f8d7da;
            color: #721c24;
            border-color: #f5c6cb;
        }
    </style>
</head>
<body>
    <c:choose>
        <c:when test="${param.action == 'deleted'}">
            <div class="message-box error">
                🗑️ Recensione eliminata con successo!<br>
                Verrai reindirizzato tra qualche secondo...
            </div>
        </c:when>
        <c:otherwise>
            <div class="message-box">
                ✅ Recensione aggiunta con successo!<br>
                Verrai reindirizzato tra qualche secondo...
            </div>
        </c:otherwise>
    </c:choose>
</body>
</html>
