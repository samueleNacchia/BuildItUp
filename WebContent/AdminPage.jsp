<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.Product.ProductDAO, model.Order.OrderDAO" %>
<%@ page import="model.Product.ProductDTO, model.Order.OrderDTO" %>

<%/*
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
   	response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);*/

	ProductDAO productDao = new ProductDAO();
	OrderDAO orderDao  = new OrderDAO();
    List<ProductDTO> prodotti = productDao.findAll();
    List<OrderDTO> ordini = orderDao.findAll();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Panel</title>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="css/StyleView.css?v=<%= System.currentTimeMillis() %>">
    
</head>
<body>      
       
<h1>Pannello di Amministrazione</h1>
<a href="index.html">Home</a>
<br>
<!-- Sezione: Inserimento nuovo prodotto -->
<h2>Inserisci Nuovo Prodotto</h2>
<form action="AddProduct" method="post" enctype="multipart/form-data">
    Nome: <input type="text" name="nome" required /><br><br>
    Descrizione: <input type="textarea" name="descrizione" /><br><br>
    Prezzo: <input type="number" name="prezzo" step="0.01" required /><br><br>
    Categoria: 
    	<select name="categoria">
        	<option value="CPU" selected>CPU</option>
            <option value="GPU">GPU</option>
            <option value="MOBO">MOBO</option>
            <option value="CASE">CASE</option>
            <option value="COOLING">COOLING</option>
            <option value="RAM">RAM</option>
            <option value="MEM">MEM</option>
            <option value="PSU">PSU</option>
    	</select>        
    <br><br>
    Disponibilità: <input type="number" name="stocks" min=0 step="1" required /><br><br>
    
    Immagine 1: <input type="file" id="fileInput1" name="immagine1" accept="image/*">
    <button type="button" onclick="document.getElementById('fileInput1').value = '';">Reset</button>
    <br><br>
    Immagine 2: <input type="file" id="fileInput2" name="immagine2" accept="image/*">
    <button type="button" onclick="document.getElementById('fileInput2').value = '';">Reset</button>
    <br><br>
    Immagine 3: <input type="file" id="fileInput3" name="immagine3" accept="image/*">
    <button type="button" onclick="document.getElementById('fileInput3').value = '';">Reset</button>
    <br><br>
    <input type="submit" value="Aggiungi Prodotto">
</form>

<!-- Sezione: Lista prodotti -->
<h2 align="center">Prodotti in Catalogo</h2>

<table>
    <tr>
    	<th>Codice</th>
        <th>Nome</th>
        <th>Descrizione</th>
        <th>Prezzo</th>
        <th>Sconto</th>
        <th>Categoria</th>
        <th>InVendita</th>
        <th>Quantità</th>
        <th>Img1</th>
        <th>Img2</th>
        <th>Img3</th>
        <th>Azioni</th>
    </tr>
    <%
        if (prodotti != null) {
            for (ProductDTO p : prodotti) {
    %>
    <tr>
        <form action="UpdateProduct" method="post" enctype="multipart/form-data">
        	<td><%= p.getId() %><input type="hidden" name="id" value="<%= p.getId() %>"></td>
            <td><input type="text" name="nome" value="<%= p.getName() %>" /></td>
            <td><input type="text" name="descrizione" value="<%= p.getDescription() %>" /></td>
            <td><input type="number" min=0 name="prezzo" value="<%= p.getPrice() %>" step="0.01" /></td>
            <td><input type="number" max=1 min=0 name="sconto" value="<%= p.getDiscount() %>" step="0.01" /></td>		
            <td>
            	<select name="categoria">
				    <option value="CPU" <% if ("CPU".equals(p.getCategory().name())) { %>selected<% } %>>CPU</option>
				    <option value="GPU" <% if ("GPU".equals(p.getCategory().name())) { %>selected<% } %>>GPU</option>
				    <option value="MOBO" <% if ("MOBO".equals(p.getCategory().name())) { %>selected<% } %>>MOBO</option>
				    <option value="CASE" <% if ("CASE".equals(p.getCategory().name())) { %>selected<% } %>>CASE</option>
				    <option value="COOLING" <% if ("COOLING".equals(p.getCategory().name())) { %>selected<% } %>>COOLING</option>
				    <option value="RAM" <% if ("RAM".equals(p.getCategory().name())) { %>selected<% } %>>RAM</option>
				    <option value="MEM" <% if ("MEM".equals(p.getCategory().name())) { %>selected<% } %>>MEM</option>
				    <option value="PSU" <% if ("PSU".equals(p.getCategory().name())) { %>selected<% } %>>PSU</option>
				</select>
            </td>  
            <td><input type="checkbox" name="inVendita" value="true" <% if (p.isOnSale()) { %> checked <% } %> /></td>
            <td><input type="number" name="stocks" min=0 value="<%= p.getStocks() %>" step="1" /></td>
            
            <td><img src="<%= request.getContextPath() %>/image?id=<%= p.getId() %>&n=1" >
            <input type="submit" name="deleteImage" value="1">
    		<input type="file" name="immagine1" accept="image/*"></td>
            
            <td><img src="<%= request.getContextPath() %>/image?id=<%= p.getId() %>&n=2" >
            <input type="submit" name="deleteImage" value="2">
    		<input type="file" name="immagine2" accept="image/*"></td>
            
            <td><img src="<%= request.getContextPath() %>/image?id=<%= p.getId() %>&n=3" >
            <input type="submit" name="deleteImage" value="3">
    		<input type="file" name="immagine3" accept="image/*"></td>
            
            <td>
            <input type="submit" value="update" onclick="return confirm('Aggiornare <%=p.getName() %>?')"/>
     	</form>  
            
            <a href="AddToList?type=wishlist&id=<%=p.getId()%>" style="text-decoration: none; cursor: pointer; enctype="multipart/form-data"">
  				<i class="fa-solid fa-heart" id="wishlist-icon" style="font-size: 20px; color: dimgray;"></i>
			</a>

			<a href="AddToList?type=cart&id=<%=p.getId()%>" style="text-decoration: none; cursor: pointer; enctype="multipart/form-data"">
  				<i class="fa-solid fa-shopping-cart" id="cart-icon" style="font-size: 20px; color: dimgray"></i>
			</a>
			</td>
       
    </tr>
    <%
            }
        } else {
    %>
    <tr><td colspan="5">Nessun prodotto disponibile.</td></tr>
    <% } %>
</table>



<!-- Sezione: Visualizzazione ordini -->
<h2 align="center">Ordini</h2>


<table>
    <tr>
        <th>ID Ordine</th>
        <th>Cliente</th>
        <th>Data</th>
        <th>Stato</th>
        <th>Azioni</th>
    </tr>
    <%
        if (ordini != null) {
            for (OrderDTO o : ordini) {
    %>
    <tr>
		<form action="UpdateOrder" method="post">
            <td><%= o.getId() %><input type="hidden" name="id" value="<%= o.getId() %>" /></td>
            <td><%= o.getId_user() %></td>
            <td><%= o.getOrderDate() %></td>
            <td>
                <select name="stato">
                    <option value="In_elaborazione" <% if ("In_elaborazione".equals(o.getStatus().name())) { %>selected<% } %>>In_elaborazione</option>
				    <option value="Elaborato" <% if ("Elaborato".equals(o.getStatus().name())) { %>selected<% } %>>Elaborato</option>
				    <option value="Spedito" <% if ("Spedito".equals(o.getStatus().name())) { %>selected<% } %>>Spedito</option>
				    <option value="Consegnato" <% if ("Consegnato".equals(o.getStatus().name())) { %>selected<% } %>>Consegnato</option>
				    <option value="Annullato" <% if ("Annullato".equals(o.getStatus().name())) { %>selected<% } %>>Annullato</option>
                </select>
            </td>
            <td><input type="submit" value="update"/></td>
        </form>
    </tr>
    <%
            }
        } else {
    %>
    <tr><td colspan="5">Nessun ordine trovato.</td></tr>
    <% } %>
</table>

</body>
</html>
