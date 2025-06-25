<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String status = request.getParameter("status");
%>
<html>
<head>
    <title>Stato Iscrizione</title>
    <meta http-equiv="refresh" content="2; URL=<%= request.getContextPath() %>/common/Home">
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
<% if ("success".equals(status)) { %>
    <h2 class="success">🎉 Iscrizione completata con successo!</h2>
    <p>Verrai reindirizzato alla home tra pochi secondi...</p>
<% } else { %>
    <h2 class="fail">⚠️ Si è verificato un errore durante l'iscrizione.</h2>
    <p>Verrai reindirizzato alla home tra pochi secondi...</p>
<% } %>
</body>
</html>
