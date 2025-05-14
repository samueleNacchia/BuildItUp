<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.ProductDTO" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>Product</title>
</head>
<body>
    <h1>Product List</h1>
	
    <%
        List<ProductDTO> prodotti = (List<ProductDTO>) request.getAttribute("prodotti");
        if (prodotti == null || prodotti.isEmpty()) {
    %>
        <p>Nessun prodotto disponibile.</p>
    <%
        } else {
    %>
        <table border="1">
            <tr>
                <th>Codice</th>
                <th>Nome</th>
                <th>Descrizione</th>
                <th>Prezzo</th>
                <th>Sconto (%)</th>
                <th>InVendita</th>
                <th>Quantità</th>
            </tr>
            <%
                for (ProductDTO p : prodotti) {
            %>
                <tr>
                    <td><%= p.getId() %></td>
                    <td><%= p.getName() %></td>
                    <td><%= p.getDescription() %></td>
                    <td><%= p.getPrice() %></td>
                    <td><%= p.getDiscount() %></td>
                    <td><%= p.isOnSale() %></td>
                    <td><%= p.getStocks() %></td>
                </tr>
            <%
                }
            %>
        </table>
    <%
        }
    %>
</body>
</html>