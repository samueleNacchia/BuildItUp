<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Product.ProductDTO" %>
<%@ page import="model.ProductImage.ProductImageDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

<%	
        List<ProductDTO> prodotti = (List<ProductDTO>) request.getAttribute("prodotti");
        Map<Integer, ProductImageDTO> coverImages = (Map<Integer, ProductImageDTO>) request.getAttribute("coverImages");
        int current = 1, total=1;
		Integer Current = (Integer) request.getAttribute("currentPage");
        Integer Total =  (Integer) request.getAttribute("totalPages");
        if (Current != null) current = Current;
        if (Total != null) total = Total;
        
        String category = (String) request.getAttribute("category");
	    Double minPrice = (Double) request.getAttribute("minPrice");
	    Double maxPrice = (Double) request.getAttribute("maxPrice");
	    String name = (String) request.getAttribute("name");
	    String type = (String) request.getAttribute("type");
%>


<!DOCTYPE html>
<html>
<head>
<title>BuildItUp</title>
<style>html{display:none}</style>

<%@ include file="header.html"  %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link rel="stylesheet" href="./css/style_catalog.css?v=<%= System.currentTimeMillis() %>">
<link rel="stylesheet" href="./css/style_header.css?v=<%= System.currentTimeMillis() %>">
<link rel="stylesheet" href="./css/style_footer.css?v=<%= System.currentTimeMillis()%>">

</head>
<body>
<a href="Home">Home</a>
	<main class="homepage">
	
	<div class="catalog-layout">
	
	<section class="filter-bar-horizontal">
	
	<form method="POST" action="CatalogViewer"  class="filter-form-horizontal">
	Prezzo minimo: 	<input type="number" name="minPrice" value="<%= minPrice != null ? minPrice : "" %>"><br>
	Prezzo massimo:	<input type="number" name="maxPrice" value="<%= maxPrice != null ? maxPrice : "" %>"><br>
	
	
	Categoria
	<select name="category" id="category">
		<option value="" <% if ("".equals(category)) { %>selected<% } %>>Tutte le categorie</option>
		<option value="CPU" <% if ("CPU".equals(category)) { %>selected<% } %>>CPU</option>
		<option value="GPU" <% if ("GPU".equals(category)) { %>selected<% } %>>GPU</option>
		<option value="MOBO" <% if ("MOBO".equals(category)) { %>selected<% } %>>MOBO</option>
		<option value="CASE" <% if ("CASE".equals(category)) { %>selected<% } %>>CASE</option>
		<option value="COOLING" <% if ("COOLING".equals(category)) { %>selected<% } %>>COOLING</option>
		<option value="RAM" <% if ("RAM".equals(category)) { %>selected<% } %>>RAM</option>
		<option value="MEM" <% if ("MEM".equals(category)) { %>selected<% } %>>MEM</option>
		<option value="PSU" <% if ("PSU".equals(category)) { %>selected<% } %>>PSU</option>
	</select>
		
	<label>
	  	<input type="radio" name="type" value="discounts" <% if (type != null && type.equals("discounts")) { %> checked <% } %>>In sconto
	</label>
	
	<label>
		<input type="radio" name="type" value="bestsellers" <% if (type != null && type.equals("bestsellers")) { %> checked <% } %>> Best Sellers
	</label>
	<button type="button" onclick="document.querySelectorAll('input[name=type]').forEach(el => el.checked = false)">Deseleziona</button>
	<button type="submit">Filtra</button>
	</form>
	</section>
	<%	
		if (prodotti == null || prodotti.isEmpty()) {
	%>
			<p>Nessun prodotto corrispondente</p>
	<%
		} else {
	%>
			<div class="products">
			<% 
				for (ProductDTO product : prodotti) {
					ProductImageDTO image = coverImages.get(product.getId());
			%>
					<a href="ProductDetails?id=<%= product.getId() %>" class="product-link">
					<div class="product-card">
						<%
					        if (image != null) {
		    			%>
		        			<img src="image?id=<%= image.getId() %>" alt="Immagine di copertina">
					    <%
					        } else {
					    %>
					        <img src="img/default.jpg" alt="Nessuna immagine disponibile">
					    <%
					        }
					    %>
						<h3><%= product.getName() %></h3>
						<h4><%= product.getPrice() %> €</h4>
						<%
							if (product.getDiscount()>0){
						%>
						<h5><p class="discount">Sconto: <%= String.format("%.2f", product.getDiscount()*100) %>%</p></h5> 
						<%
							} 
						%>
					</div>
					</a>
			<% 
				} 
			%>
			</div>
	<% 
		} 
	%>
		<div id="pagination">
		<% 
			
			for (int i=1; total>1 && i<=total; i++) {
				String active = "";
				if (i == current) active = "active";
							
				 StringBuilder link = new StringBuilder("CatalogViewer?page=" + i);
				 			
				if (type != null) link.append("&type=").append(type);
				if (category != null && !category.isEmpty()) link.append("&category=").append(category);
				if (minPrice != null) link.append("&minPrice=").append(minPrice);
				if (maxPrice != null) link.append("&maxPrice=").append(maxPrice);
				if (name != null) link.append("&name=").append(name);
		%>
				<a href="<%= link.toString() %>" class="<%= active %>"><%= i %></a>
		<% 
			} 
		%>
		</div>
	</div>
</main>

<%@ include file="footer.html"  %>

<script>
  window.addEventListener("load", function() {
    document.documentElement.style.display = "block";
  });
</script>

</body>
</html>