<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="model.Product.ProductDTO" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet" href="css/StyleView.css?v=<%= System.currentTimeMillis() %>">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link rel="stylesheet" href="./css/style_catalog.css">
<link rel="stylesheet" href="./css/style_header.css">
<link rel="stylesheet" href="./css/style_footer.css">

<meta charset="UTF-8">
<title>BuildItUp</title>
</head>
<body>
<%@ include file="header.html"  %>


<br><br><br>

<main class="homepage">

<div class="catalog-layout">

<section class="filter-bar-horizontal">

<form method="get" action="CatalogViewer"  class="filter-form-horizontal">
Prezzo minimo: <input type=number name="minPrice"><br>
Prezzo massimo: <input type=number name="maxPrice"><br>


Categoria
<select name="category" id="category">
    <option value="">Tutte le categorie</option>
    <option value="CPU">Processori</option>
    <option value="MOBO">Schede madri</option>
    <option value="GPUe">Schede grafiche</option>
    <option value="RAM">RAM</option>
    <option value="MEM">Memorie</option>
    <option value="PSU">Alimentatori</option>
    <option value="CASE">Case</option>
    <option value="COOLING">Raffreddamento</option>
</select>


<br>


<label>
  <input type="radio" name="type" value="discounts"> In sconto
</label>

<label>
  <input type="radio" name="type" value="bestsellers"> Best Sellers
</label>


<button type="submit">Filtra</button>

</form>


</section>
<%	
        List<ProductDTO> prodotti = (List<ProductDTO>) request.getAttribute("prodotti");
        int current = (Integer) request.getAttribute("currentPage");
        int total = (Integer) request.getAttribute("totalPages");
        String category = (String) request.getAttribute("category");
	    Double minPrice = (Double) request.getAttribute("minPrice");
	    Double maxPrice = (Double) request.getAttribute("maxPrice");
	    String name = (String) request.getAttribute("name");
	    String type = (String) request.getAttribute("type");
	    
	    if (prodotti == null || prodotti.isEmpty()) {
	    	%>
	    	        <p>Nessun prodotto corrispondente.</p>
	  		<%
	    	        } else {
	    	%>


			<div class="products">
					  <% for (ProductDTO u : prodotti) {
					       %>
					    
					    <a href="productDetails?id=<%= u.getId() %>" class="product-link">
					    <div class="product-card">
					    
							<%
						        byte[] imgBytes = u.getImage1();
						        if (imgBytes != null) {
			            		
			    			%>
			    			
			        			<img src="image?id=<%= u.getId() %>&n=1" >
						    <%
						        } else {
						    %>
						        <img src="img/default.jpg" alt="Nessuna immagine disponibile">
						    <%
						        }
						    %>
					    
					      <h3><%= u.getName() %></h3>
					      <h4><%= u.getPrice() %> €</h4>
					      
						</div>
						</a>
						
					<% } %>
			
			
			</div>


			<% } %>
 



<br><br><br><br><br><br>

<div id="pagination">
  <% for (int i = 1; i <= total; i++) {
       String active = (i == current) ? "active" : "";
  %>
    <a href="CatalogViewer?page=<%= i %>
    <% if (type != null) { %>&type=<%= type %><% } %>
    <% if (category != null) { %>&category=<%= category %><% } %>
    <% if (minPrice != null) { %>&minPrice=<%= minPrice %><% } %>
    <% if (maxPrice != null) { %>&maxPrice=<%= maxPrice %><% } %>
    <% if (name != null) { %>&name=<%= name %><% } %>">
    <%= i %>
</a>
    
  <% } %>
</div>

</div>
</main>


<%@ include file="footer.html"  %>
</body>
</html>