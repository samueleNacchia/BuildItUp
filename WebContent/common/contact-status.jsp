<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
    <title>Stato Iscrizione</title>
    <meta http-equiv="refresh" content="2; URL=${pageContext.request.contextPath}/common/Home">
    <style>
        body {
            font-family: sans-serif;
            text-align: center;
            padding: 50px;
        }
        .success {
            color: green;
        }
        .fail {
            color: red;
        }
    </style>
</head>
<body>


<c:choose>
  <c:when test="${param.status == 'success'}">
    <h2 class="success">🎉 Messaggio inviato con successo!</h2>
    <p>Verrai reindirizzato alla home tra pochi secondi...</p>
  </c:when>
  
  <c:otherwise>
    <h2 class="fail">⚠️ Si è verificato un errore durante l'invio.</h2>
    <p>Verrai reindirizzato alla home tra pochi secondi...</p>
  </c:otherwise>
</c:choose>

</body>
</html>
