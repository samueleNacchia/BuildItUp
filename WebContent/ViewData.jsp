<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Order.OrderDTO" %>
<%@ page import="model.ProductOrder.ProductOrderDTO" %>
<%@ page import="model.Review.ReviewDTO" %>
<%@ page import="model.Bill.BillDTO" %>
<%@ page import="model.Newsletter.NewsletterDTO" %>
<%@ page import="model.List.ListDTO" %>
<%@ page import="model.ItemList.ItemListDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>



<% DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy"); %>

<!DOCTYPE html>
<html>
<head>
<!-- <td><fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy" /></td> -->
    <title>Product-Users</title>
	<link rel="stylesheet" href="css/StyleView.css?v=<%= System.currentTimeMillis() %>">
</head>
<body>
	<a href="Home">Home</a>

	<h1>Utenti</h1>
	
    <c:if test="${not empty utenti}">
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
            <c:forEach var="utente" items="${utenti}">
                <tr>
                    <td>${utente.id}</td>
                    <td>${utente.email}</td>
                    <td>${utente.password}</td>
                    <td><${utente.name}</td>
                    <td>${utente.surname}</td>
                    <td>${utente.via}</td>
                    <td>${utente.roadNum}</td>
                    <td>${utente.postalCode}</td>
                    <td>${utente.tel}</td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
       
    <h1>Admin</h1>
	
    <c:if test="${not empty admin}">
        <table>
            <tr>
                <th>Email</th>
                <th>Password</th>
            </tr>
            <c:forEach var="admin" items="${admin}">
                <tr>
                    <td>${admin.email}</td>
                    <td>${admin.password}</td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
    
    
    
    
    <h1>Prodotti</h1>
	
     <c:if test="${not empty prodotti}">
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
            </tr>
            <c:forEach var="prodotto" items="${prodotti}">
                <tr>
                    <td>${prodotto.id}</td>
                    <td>${prodotto.name}</td>
                    <td>${prodotto.category}</td>
                    <td>${prodotto.description}</td>
                    <td>${prodotto.price}</td>
                    <td>${prodotto.discount}</td>
                    <td>${prodotto.onSale}</td>
                    <td>${prodotto.stocks}</td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
    
    
    <h1>Immagini</h1>
	
    <c:if test="${not empty image}">
        <table>
            <tr>
                <th>Codice</th>
                <th>Id Prodotto</th>
                <th>Immagine</th>
            </tr>
            <c:forEach var="image" items="${image}">
                <tr>
                    <td>${image.id}</td>
                    <td>${image.idProduct}</td>
                    <td><img src="image?id=${image.id}"></td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
    

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