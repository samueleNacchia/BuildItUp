<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Product.ProductDTO" %>
<%@ page import="model.User.UserDTO" %>
<%@ page import="model.Admin.AdminDTO" %>
<%@ page import="model.Order.OrderDTO" %>
<%@ page import="model.ProductOrder.ProductOrderDTO" %>
<%@ page import="model.Review.ReviewDTO" %>
<%@ page import="model.Bill.BillDTO" %>
<%@ page import="model.Newsletter.NewsletterDTO" %>
<%@ page import="model.List.ListDTO" %>
<%@ page import="model.ItemList.ItemListDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<% DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy"); %>

<html>
<head>
    <title>Product-Users</title>
	<link rel="stylesheet" href="css/StyleView.css?v=<%= System.currentTimeMillis() %>">
</head>
<body>
	<a href="Home">Home</a>

	<h1>Utenti</h1>
	
    <%
        List<UserDTO> utenti = (List<UserDTO>) request.getAttribute("utenti");
        if (utenti == null || utenti.isEmpty()) {
    %>
        <p>Nessun utente disponibile.</p>
    <%
        } else {
    %>
        <table>
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
    
    
    <h1>Admin</h1>
	
    <%
        List<AdminDTO> admin = (List<AdminDTO>) request.getAttribute("admin");
        if (admin == null || admin.isEmpty()) {
    %>
        <p>Nessun admin disponibile.</p>
    <%
        } else {
    %>
        <table>
            <tr>
                <th>Email</th>
                <th>Password</th>
            </tr>
            <%
                for (AdminDTO a : admin) {
            %>
                <tr>
                    <td><%= a.getEmail() %></td>
                    <td><%= a.getPassword() %></td>
                </tr>
            <%
                }
            %>
        </table>
    <%
        }
    %>
    
    
    
    
    <h1>Prodotti</h1>
	
    <%	
        List<ProductDTO> prodotti = (List<ProductDTO>) request.getAttribute("prodotti");
        if (prodotti == null || prodotti.isEmpty()) {
    %>
        <p>Nessun prodotto disponibile.</p>
    <%
        } else {
    %>
        <table>
            <tr>
                <th>Codice</th>
                <th>Nome</th>
                <th>Categoria</th>
                <th>Descrizione</th>
                <th>Prezzo</th>
                <th>Sconto (%)</th>
                <th>InVendita</th>
                <th>Quantità</th>
                <th>Img1</th>
                <th>Img2</th>
                <th>Img3</th>
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
                    <td><img src="image?id=<%= p.getId() %>&n=1" >
                    <td><img src="image?id=<%= p.getId() %>&n=2" >
                    <td><img src="image?id=<%= p.getId() %>&n=3" >
                </tr>
            <%
                }
            %>
        </table>
    <%
        }
    %>
    
    
    
    
    <h1>Ordini</h1>
	
    <%	
        List<OrderDTO> ordini = (List<OrderDTO>) request.getAttribute("ordini");
        if (ordini == null || ordini.isEmpty()) {
    %>
        <p>Nessun ordine disponibile.</p>
    <%
        } else {
    %>
        <table>
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
                    <td><%= o.getOrderDate().format(formatter) %></td>
                    <td><%= o.getStatus() %></td>
                </tr>
            <%
                }
            %>
        </table>
    <%
        }
    %>
    
    
    <h1>ProdottiOrdine</h1>
	
    <%	
        List<ProductOrderDTO> prodottiOrdine = (List<ProductOrderDTO>) request.getAttribute("prodottiOrdinati");
        if (prodottiOrdine == null || prodottiOrdine.isEmpty()) {
    %>
        <p>Nessun prodotto disponibile.</p>
    <%
        } else {
    %>
        <table>
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
    
    
    
    <h1>Recensioni</h1>
	
    <%	
        List<ReviewDTO> recensioni = (List<ReviewDTO>) request.getAttribute("recensioniProdotto");
        if (recensioni == null || recensioni.isEmpty()) {
    %>
        <p>Nessuna recensione del prodotto disponibile.</p>
    <%
        } else {
    %>
        <table>
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
                    <td><%= r.getReviewDate().format(formatter) %></td>
                </tr>
            <%
                }
            %>
        </table>
    <%
        }
    %>   
    
    <h1>Fatture</h1>
	
    <%	
        List<BillDTO> fatture = (List<BillDTO>) request.getAttribute("fatture");
        if (fatture == null || fatture.isEmpty()) {
    %>
        <p>Nessuna fattura disponibile.</p>
    <%
        } else {
    %>
        <table>
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
                    <td><%= b.getBillDate().format(formatter) %></td>
                </tr>
            <%
                }
            %>
        </table>
    <%
        }
    %>
    
    
    <h1>Newsletter</h1>
	
    <%	
        List<NewsletterDTO> Newsletter = (List<NewsletterDTO>) request.getAttribute("news");
        if (Newsletter == null || Newsletter.isEmpty()) {
    %>
        <p>Nessuna Newsletter disponibile.</p>
    <%
        } else {
    %>
        <table>
            <tr>
                <th>Email</th>
            </tr>
            <%
                for (NewsletterDTO n : Newsletter) {
            %>
                <tr>
                    <td><%= n.getEmail() %></td>
                </tr>
            <%
                }
            %>
        </table>
    <%
        }
    %>
    
    
    
    <h1>Liste</h1>
	
    <%	
        List<ListDTO> liste = (List<ListDTO>) request.getAttribute("liste");
        if (liste == null || liste.isEmpty()) {
    %>
        <p>Nessuna lista disponibile.</p>
    <%
        } else {
    %>
        <table>
            <tr>
                <th>Codice</th>
                <th>Token</th>
                <th>Codice utente</th>
                <th>Tipologia</th>
                <th>Ultimo accesso</th>
            </tr>
            <%
                for (ListDTO l : liste) {
            %>
                <tr>
                    <td><%= l.getId() %></td>
                    <td><%= l.getToken() %></td>
                    <td><%= l.getId_user() %></td>
                    <td><%= l.getType() %></td>
                    <td><%= l.getLastAccess() %></td>
                </tr>
            <%
                }
            %>
        </table>
    <%
        }
    %>
    
    
    
    <h1>Item delle liste</h1>
	
    <%	
        List<ItemListDTO> item = (List<ItemListDTO>) request.getAttribute("item");
        if (item == null || item.isEmpty()) {
    %>
        <p>Nessuna fattura disponibile.</p>
    <%
        } else {
    %>
        <table>
            <tr>
                <th>Codice lista</th>
                <th>Codice prodotto</th>
                <th>Quantità</th>
            </tr>
            <%
                for (ItemListDTO i : item) {
            %>
                <tr>
                    <td><%= i.getId_list() %></td>
                    <td><%= i.getId_product() %></td>
                    <td><%= i.getQuantity() %></td>
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