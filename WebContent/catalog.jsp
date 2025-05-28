<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Product.ProductDTO" %>
<%@ page import="java.util.List" %>

<%	
        List<ProductDTO> prodotti = (List<ProductDTO>) request.getAttribute("prodotti");
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
<link rel="stylesheet" href="css/StyleView.css?v=<%= System.currentTimeMillis() %>">
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
	    <option value="" <%= category == null ? "selected" : "" %>>Tutte le categorie</option>
	    <option value="CPU" <%= "CPU".equals(category) ? "selected" : "" %>>Processori</option>
	    <option value="MOBO" <%= "MOBO".equals(category) ? "selected" : "" %>>Schede Madri</option>
	    <option value="GPU" <%= "GPU".equals(category) ? "selected" : "" %>>Schede Grafiche</option>
	    <option value="RAM" <%= "RAM".equals(category) ? "selected" : "" %>>RAM</option>
	    <option value="MEM" <%= "MEM".equals(category) ? "selected" : "" %>>Memorie</option>
	    <option value="PSU" <%= "PSU".equals(category) ? "selected" : "" %>>Alimentatori</option>
	    <option value="CASE" <%= "CASE".equals(category) ? "selected" : "" %>>Case</option>
	    <option value="COOLING" <%= "COOLING".equals(category) ? "selected" : "" %>>Raffreddamento</option>
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
			%>
					<a href="productDetails?id=<%= product.getId() %>" class="product-link">
					<div class="product-card">
						<%
							byte[] imgBytes = product.getImage1();
							if (imgBytes != null) {
					    %>
				    	<img src="image?id=<%= product.getId() %>&n=1" >
						<%
							} else {
						%>
							    	<img src="img/default.jpg" alt="Nessuna immagine disponibile">
						<%
							}
						%>
						<h3><%= product.getName() %></h3>
						<h4><%= String.format("%.2f",product.getPrice()) %> €</h4>
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
			for (int i = 1; i <= total; i++) {
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