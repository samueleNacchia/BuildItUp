<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.Product.ProductDAO, model.Order.OrderDAO, model.ProductImage.ProductImageDAO" %>
<%@ page import="model.Product.ProductDTO, model.Order.OrderDTO, model.ProductImage.ProductImageDTO" %>

<%
	ProductDAO productDao = new ProductDAO();
	OrderDAO orderDao  = new OrderDAO();
    List<ProductDTO> prodotti = productDao.findAll();
    List<OrderDTO> ordini = orderDao.findAll();
    ProductImageDAO imageDao = new ProductImageDAO();
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
<a href="Home">Home</a>
<br>
<!-- Sezione: Inserimento nuovo prodotto -->
<h2>Inserisci Nuovo Prodotto</h2>

<form action="AddProduct" method="post" enctype="multipart/form-data">
    <label>Nome: <input type="text" name="nome" required /></label>
    <label>Descrizione: <textarea name="descrizione"></textarea></label>
    <label>Prezzo: <input type="number" name="prezzo" step="0.01" required /></label>
    <label>Categoria: 
    <select name="categoria">
        <option value="CPU" selected>CPU</option>
        <option value="GPU">GPU</option>
        <option value="MOBO">MOBO</option>
        <option value="CASE">CASE</option>
        <option value="COOLING">COOLING</option>
        <option value="RAM">RAM</option>
        <option value="MEM">MEM</option>
        <option value="PSU">PSU</option>
    </select></label>
    <label>Disponibilità: <input type="number" name="stocks" min="0" step="1" required /></label>

	<label>Immagine di copertina: <input type="file" name="copertina" accept="image/*"></label>

    <label>Altre Immagini: <input type="file" name="immagini" id="fileInput" accept="image/*" multiple></label>
    <br>
	<button type="button" onclick="document.getElementById('fileInput').value = '';">Reset</button>
	
    <input type="submit" class="add" value="Aggiungi Prodotto">
</form>


<!-- Sezione: Lista prodotti -->
<h2 align="center">Prodotti in Catalogo</h2>

<table>
    <tr>
        <th>Nome</th>
        <th>Descrizione</th>
        <th>Prezzo</th>
        <th>Sconto</th>
        <th>InVendita</th>
        <th>Quantità</th>
        <th>Azioni</th>
        <th>Immagini</th>
    </tr>
    <%
        if (prodotti != null) {
            for (ProductDTO product : prodotti) {
    %>
    <tr>
        <form action="UpdateProduct" method="post">
		    <input type="hidden" name="id" value="<%= product.getId() %>"></td>
		    <td><%= product.getName() %><input type="hidden" name="name" value="<%= product.getName() %>"></td>
		    <td><input type="text" name="descrizione" value="<%= product.getDescription() %>" /></td>
		    <td><input type="number" min=0 name="prezzo" value="<%= product.getPrice() %>" step="0.01" /></td>
		    <td><input type="number" max=1 min=0 name="sconto" value="<%= product.getDiscount() %>" step="0.01" /></td>		
		   	<input type="hidden" name="category" value="<%= product.getCategory() %>"></td>
		    <td><input type="checkbox" name="inVendita" value="true" <% if (product.isOnSale()) { %> checked <% } %> /></td>
		    <td><input type="number" name="stocks" min=0 value="<%= product.getStocks() %>" step="1" /></td>
		    <td>
		        <input type="submit" class="update" value="Update" onclick="return confirm('Aggiornare <%= product.getName() %>?')" />
		</form> 
	
			<a href="AddToList?type=wishlist&id=<%=product.getId()%>" style="text-decoration: none; cursor: pointer; enctype="multipart/form-data"">
  				<i class="fa-solid fa-heart" id="wishlist-icon" style="font-size: 20px; color: dimgray;"></i>
			</a>

			<a href="AddToList?type=cart&id=<%=product.getId()%>" style="text-decoration: none; cursor: pointer; enctype="multipart/form-data"">
  				<i class="fa-solid fa-shopping-cart" id="cart-icon" style="font-size: 20px; color: dimgray"></i>
			</a>
			</td> 
	
	<td colspan="11">
    <div style="display: flex; align-items: center; gap: 10px;">
        <%
        	List<ProductImageDTO> immagini = imageDao.findAllByProduct(product.getId());
            for (ProductImageDTO img : immagini) {
            	
        %>
            <form action="DeleteImage" method="post" style="display:inline">
                <img src="image?id=<%= img.getId() %>" height="100" />
                <input type="hidden" name="imageId" value="<%= img.getId() %>">
                <input type="submit" class="delete" value="X" onclick="return confirm('Eliminare questa immagine?')">
            </form>
        <%
            }
        %>        
        <form action="AddImages" method="post" enctype="multipart/form-data">
            <input type="hidden" name="productId" value="<%= product.getId() %>">
            <input type="file" name="copertina" accept="image/*">
            <input type="submit" class="add" value="Aggiungi Copertina">
        </form>
        <form action="AddImages" method="post" enctype="multipart/form-data">
            <input type="hidden" name="productId" value="<%= product.getId() %>">
            <input type="file" name="immagini" accept="image/*" multiple>
            <input type="submit" class="add" value="Aggiungi immagini">
        </form>
    </div>
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
            <td><input type="submit" class="update" value="update"/></td>
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
