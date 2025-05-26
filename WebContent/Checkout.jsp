<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.*, model.ItemList.ItemListDTO" %>
<%@ page import="model.Product.ProductDTO" %>
<%
    List<ItemListDTO> prodotti = (List<ItemListDTO>) request.getAttribute("items");
    float total = 0;
%>

<html>
<head>
    <title>Riepilogo Ordine</title>
    <link rel="stylesheet" href="css/StyleView.css?v=<%= System.currentTimeMillis() %>">  
</head>
<body>
<a href="Home">Home</a>
    <h2>Riepilogo del tuo ordine</h2>
    <table>
        <tr>
            <th>Prodotto</th>
            <th>Quantità</th>
            <th>Prezzo unitario</th>
            <th>Subtotale</th>
        </tr>
        <%
            for (ItemListDTO item : prodotti) {
                int quantity = item.getQuantity(); // supponiamo che la quantità sia salvata nel prodotto
                float price = item.getProduct().getPrice() * (1-item.getProduct().getDiscount());
                float subtotal = quantity * price;
                total += subtotal;
        %>
        <tr>
            <td><%= item.getProduct().getName() %></td>
            <td><%= quantity %></td>
            <td>€ <%= String.format("%.2f", price) %></td>
            <td>€ <%= String.format("%.2f", subtotal) %></td>
        </tr>
        <% } %>
        <tr class="totale">
            <td colspan="3">Totale</td>
            <td>€ <%= String.format("%.2f", total) %></td>
        </tr>
    </table>

    <a href="SaveOrder" style="text-decoration: none;">
  		<input type="submit" value="Conferma Ordine">
	</a>
    
</body>
</html>