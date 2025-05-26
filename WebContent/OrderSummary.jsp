<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="model.Order.OrderDTO" %>
<%@ page import="model.Bill.BillDTO" %>
<%@ page import="model.Status" %>
<%@ page import="model.Order.*" %>
<%@ page import="model.Bill.*" %>
<%
    // Prendo il parametro id dalla query string
    String idParam = request.getParameter("id");
    OrderDTO ordine = null;
    BillDTO fattura = null;

    if (idParam != null) {
        int orderId = Integer.parseInt(idParam);

        // Recupero ordine dal DB tramite DAO
        OrderDAO orderDao = new OrderDAO();
        ordine = orderDao.findByCode(orderId);

        // Recupero fattura collegata all'ordine (se esiste)
        BillDAO billDao = new BillDAO();
        fattura = billDao.findByOrder(orderId);
    }

    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Conferma Ordine</title>
    <link rel="stylesheet" href="css/StyleView.css?v=<%= System.currentTimeMillis() %>">
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 40px;
            background-color: #f9f9f9;
        }
        .container {
            max-width: 600px;
            margin: auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            padding: 30px;
        }
        h1 {
            text-align: center;
            color: #4CAF50;
        }
        .order-info {
            margin-top: 20px;
        }
        .order-info p {
            font-size: 18px;
            margin: 10px 0;
        }
        .back-link {
            text-align: center;
            margin-top: 30px;
        }
        .back-link a {
            color: #4CAF50;
            text-decoration: none;
            font-weight: bold;
        }
        .back-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
	<%
        if (ordine != null) {
    %>
    <h1>Ordine Confermato!</h1>
    
    <div class="order-info">
        <p><strong>Numero Ordine:</strong> <%= ordine.getId() %></p>
        <p><strong>ID Utente:</strong> <%= ordine.getId_user() %></p>
        <p><strong>Totale:</strong> <%= (fattura != null) ? String.format("%.2f", fattura.getTotal()) : "N/A" %></p>
        <p><strong>Data Ordine:</strong> <%= ordine.getOrderDate().format(formatter) %></p>
        <p><strong>Stato:</strong> <%= ordine.getStatus() %></p>
    </div>
    
    <div class="back-link">
        <a href="Home"">Torna alla home</a>
    </div>
    <%
        } else {
    %>
    <p><h1 style="color:red;">Ordine Fallito!</h1></p>
    <a href="Home" style="color:red;">Torna alla home</a>
    <%
        }
    %>
</div>
</body>
</html>