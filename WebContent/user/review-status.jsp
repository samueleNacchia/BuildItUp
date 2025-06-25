<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Stato recensione</title>
    <meta http-equiv="refresh" content="3;URL=${pageContext.request.contextPath}/common/productDetails?id=${param.id}">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
   <style>

        body {
            font-family: sans-serif;
            background-color: #f5f5f5;
            text-align: center;
            margin-top: 100px;
            padding: 0 15px;
        }

        .message-box {
            display: inline-block;
            padding: 2em 3em;
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
            border-radius: 10px;
            font-size: 1.8rem;
            max-width: 600px;
            width: 100%;
            box-sizing: border-box;
            line-height: 1.6;
        }

        .message-box.error {
            background-color: #f8d7da;
            color: #721c24;
            border-color: #f5c6cb;
        }

        /* Per mobile */
        @media (max-width: 600px) {
            body {
                margin-top: 50px;
                padding: 0 10px;
            }

            .message-box {
                font-size: 6vw; /* Dimensione grande e scalabile per mobile */
                padding: 2em 1em;
                line-height: 1.8;
            }
        }

        /* Ancora più grande per schermi piccoli (es. 375px) */
        @media (max-width: 400px) {
            .message-box {
                font-size: 7vw;
                padding: 2em 0.5em;
            }
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
