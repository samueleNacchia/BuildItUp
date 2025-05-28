<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="model.Product.ProductDTO" %>
<%@ page import="model.ProductOrder.ProductOrderDTO" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>BuildItUp</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link rel="stylesheet" href="css/StyleView.css?v=<%= System.currentTimeMillis() %>">
<link rel="stylesheet" href="css/style_index.css?v=<%= System.currentTimeMillis() %>">
<link rel="stylesheet" href="./css/style_header.css?v=<%= System.currentTimeMillis() %>">
<link rel="stylesheet" href="./css/style_footer.css?v=<%= System.currentTimeMillis() %>">

</head>
<body>
<div class="page-wrapper">
	<%@ include file="header.html"  %>
	
	<main class="homepage">
	
	<%	
		List<ProductDTO> prodottiScontati = (List<ProductDTO>) request.getAttribute("scontati");
	    if (prodottiScontati != null && !prodottiScontati.isEmpty()) {
	%>
	     	<div id="discounts">
		     	<h1>Discounts</h1>
		        <div class="products">
		        
					<% 	
						for (ProductDTO u : prodottiScontati) {
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
				      	<p class="discount">Sconto: <%= String.format("%.2f", u.getDiscount()*100) %>%</p>
				    </div>
				    </a>
				    
				  	<%	
						} 
					%>
				</div>
				<div class="view-all">
		   			<a class="out" href="CatalogViewer?type=discounts">View All</a>
				</div>
	        </div>
	<%	
		} 
	%>

	
	<%	
		List<ProductDTO> bests = (List<ProductDTO>) request.getAttribute("bestsellers");
		if (bests != null && !bests.isEmpty()) {
	
	%>
	    	<div id="bestsellers">
		     	<h1>Best Sellers</h1>
		        <div class="products">
					<% 
					 	for (ProductDTO u : bests) {
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
				    </div>
				    </a>
				  	<%
		        		}
		     		%>
		    	</div>
				<div class="view-all">
		    		<a class="out" href="CatalogViewer?type=bestsellers">View All</a>
				</div>
			</div>
	       	<%
	        	}
	     	%>
	     
	</main>
	
	
	<a href="products" style="text-decoration: none;">
	  	<input type="submit" value="Visualizza Database">
	</a>
	
	<a href="AdminPage.jsp" style="text-decoration: none;">
	  	<input type="submit" value="Modifica Database">
	</a>	
	
	
	<div id="newsletter">
	  <form method="POST" action="iscrizione">
	    <label for="email">Iscriviti alla newsletter</label>
	    <input type="email" id="email" name="email">
	    <input type="submit">
	  </form>
	</div>
	
	
	<%@ include file="footer.html"  %>
</div>
</body>
</html>