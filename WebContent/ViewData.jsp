<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.ProductDTO" %>
<%@ page import="model.UserDTO" %>
<%@ page import="model.AdminDTO" %>
<%@ page import="model.OrderDTO" %>
<%@ page import="model.ProductOrderDTO" %>
<%@ page import="model.ReviewDTO" %>
<%@ page import="model.BillDTO" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>Product-Users</title>
	<link rel="stylesheet" href="css/StyleView.css?v=<%= System.currentTimeMillis() %>">
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
                <th>Categoria</th>
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
                    <td><%= p.getCategory() %></td>
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
    
    
    <h1>User List</h1>
	
    <%
        List<UserDTO> utenti = (List<UserDTO>) request.getAttribute("utenti");
        if (utenti == null || utenti.isEmpty()) {
    %>
        <p>Nessun utente disponibile.</p>
    <%
        } else {
    %>
        <table border="1">
            <tr>
                <th>Codice</th>
                <th>Email</th>
                <th>Password</th>
                <th>Nome</th>
                <th>Surname</th>
                <th>Via</th>
                <th>Civico</th>
                <th>CAP</th>
                <th>tel</th>
            </tr>
            <%
                for (UserDTO u : utenti) {
            %>
                <tr>
                    <td><%= u.getId() %></td>
                    <td><%= u.getEmail() %></td>
                    <td><%= u.getPassword() %></td>
                    <td><%= u.getName() %></td>
                    <td><%= u.getSurname() %></td>
                    <td><%= u.getVia() %></td>
                    <td><%= u.getRoadNum() %></td>
                    <td><%= u.getPostalCode() %></td>
                    <td><%= u.getTel() %></td>
                </tr>
            <%
                }
            %>
        </table>
    <%
        }
    %>
    
    
    <h1>Admin List</h1>
	
    <%
        List<AdminDTO> admin = (List<AdminDTO>) request.getAttribute("admin");
        if (admin == null || admin.isEmpty()) {
    %>
        <p>Nessun admin disponibile.</p>
    <%
        } else {
    %>
        <table border="1">
            <tr>
                <th>Username</th>
                <th>Password</th>
            </tr>
            <%
                for (AdminDTO a : admin) {
            %>
                <tr>
                    <td><%= a.getUsername() %></td>
                    <td><%= a.getPassword() %></td>
                </tr>
            <%
                }
            %>
        </table>
    <%
        }
    %>
    
    <h1>Order List</h1>
	
    <%	
        List<OrderDTO> ordini = (List<OrderDTO>) request.getAttribute("ordini");
        if (ordini == null || ordini.isEmpty()) {
    %>
        <p>Nessun ordine disponibile.</p>
    <%
        } else {
    %>
        <table border="1">
            <tr>
                <th>Codice</th>
                <th>Utente</th>
                <th>Data</th>
                <th>Stato</th>
            </tr>
            <%
                for (OrderDTO o : ordini) {
            %>
                <tr>
                    <td><%= o.getId() %></td>
                    <td><%= o.getId_user() %></td>
                    <td><%= o.getOrderDate() %></td>
                    <td><%= o.getStatus() %></td>
                </tr>
            <%
                }
            %>
        </table>
    <%
        }
    %>
    
    
    
    <h1>ProdottiOrdine List</h1>
	
    <%	
        List<ProductOrderDTO> prodottiOrdine = (List<ProductOrderDTO>) request.getAttribute("prodottiOrdinati");
        if (prodottiOrdine == null || prodottiOrdine.isEmpty()) {
    %>
        <p>Nessun prodotto disponibile.</p>
    <%
        } else {
    %>
        <table border="1">
            <tr>
                <th>Codice Prodotto</th>
                <th>Codice Ordine</th>
                <th>Prezzo</th>
                <th>Quantità</th>
            </tr>
            <%
                for (ProductOrderDTO po : prodottiOrdine) {
            %>
                <tr>
                    <td><%= po.getId_product() %></td>
                    <td><%= po.getId_order() %></td>
                    <td><%= po.getPrice() %></td>
                    <td><%= po.getQuantity() %></td>
                </tr>
            <%
                }
            %>
        </table>
    <%
        }
    %>
    
    
    
    <h1>Review List</h1>
	
    <%	
        List<ReviewDTO> recensioni = (List<ReviewDTO>) request.getAttribute("recensioniProdotto");
        if (recensioni == null || recensioni.isEmpty()) {
    %>
        <p>Nessuna recensione del prodotto disponibile.</p>
    <%
        } else {
    %>
        <table border="1">
            <tr>
                <th>Codice utente</th>
                <th>Codice prodotto</th>
                <th>Testo</th>
                <th>Voto</th>
                <th>Data</th>
            </tr>
            <%
                for (ReviewDTO r : recensioni) {
            %>
                <tr>
                    <td><%= r.getId_user() %></td>
                    <td><%= r.getId_product() %></td>
                    <td><%= r.getText() %></td>
                    <td><%= r.getVote() %></td>
                    <td><%= r.getReviewDate() %></td>
                </tr>
            <%
                }
            %>
        </table>
    <%
        }
    %>
    
    
    <h1>Fatture List</h1>
	
    <%	
        List<BillDTO> fatture = (List<BillDTO>) request.getAttribute("fatture");
        if (fatture == null || fatture.isEmpty()) {
    %>
        <p>Nessuna fattura disponibile.</p>
    <%
        } else {
    %>
        <table border="1">
            <tr>
                <th>Codice ordine</th>
                <th>Totale</th>
                <th>Data</th>
            </tr>
            <%
                for (BillDTO b : fatture) {
            %>
                <tr>
                    <td><%= b.getId_order() %></td>
                    <td><%= b.getTotal() %></td>
                    <td><%= b.getBillDate() %></td>
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