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
<link rel="stylesheet" href="css/style_index.css">
</head>
<body>
<%@ page import="java.util.Base64" %>
<%@ include file="header.html"  %>

<br><br><br><br><br>

<main class="homepage">

<div id="discounts">



<%	
        List<ProductDTO> prodotti = (List<ProductDTO>) request.getAttribute("prodotti");
        if (prodotti == null || prodotti.isEmpty()) {
%>
        <p>Nessun prodotto in sconto disponibile.</p>
    <%
        } else {
     %>
     
     	<h1>Discounts</h1>
        <div class="products">
		  <% for (ProductDTO u : prodotti) {
		       if (u.isOnSale() && u.getDiscount() != 0.0) { %>
		       
		    <a href="productDetails?id=<%= u.getId() %>" class="product-link">
		    <div class="product-card">
		    
		    	<%
			        byte[] imgBytes = u.getImage1();
			        if (imgBytes != null) {
			            String base64Image = Base64.getEncoder().encodeToString(imgBytes);
			    %>
			        <img src="data:image/jpeg;base64,<%= base64Image %>" alt="Immagine prodotto">
			    <%
			        } else {
			    %>
			        <img src="img/default.jpg" alt="Nessuna immagine disponibile">
			    <%
			        }
			    %>
		    	<h3><%= u.getName() %></h3>
		      <p class="discount">Sconto: <%= u.getDiscount() %>%</p>
		    </div>
		    
		  <% } } %>
		</div>

        
       <%
        }
     %>

<div class="view-all">
    <a class="out" href="">View All</a>
</div>

</div>


<br><br><br>



<div id="bestsellers">

  
<%	
        List<ProductDTO> bests = (List<ProductDTO>) request.getAttribute("bestsellers");
        if (bests == null || bests.isEmpty()) {
%>
        <p>Nessun prodotto disponibile.</p>
    <%
        } else {
     %>
     
     	<h1>Best Sellers</h1>
        <div class="products">
		  <% for (ProductDTO u : bests) {
		       %>
		    
		    <a href="productDetails?id=<%= u.getId() %>" class="product-link">
		    <div class="product-card">
		    
				<%
			        byte[] imgBytes = u.getImage1();
			        if (imgBytes != null) {
            		String base64Image = Base64.getEncoder().encodeToString(imgBytes);
    			%>
    			
        		<img src="data:image/jpeg;base64,<%= base64Image %>" alt="Immagine prodotto">
			    <%
			        } else {
			    %>
			        <img src="img/default.jpg" alt="Nessuna immagine disponibile">
			    <%
			        }
			    %>
		    
		      <h3><%= u.getName() %></h3>
		    </div>
		    
		  	<%
        }
     %>
     
    
		</div>

        
       <%
        }
     %>
     

<div class="view-all">
    <a class="out" href="">View All</a>
</div>
</div>








</main>


<form action="products" method="POST">
	<input type="Submit" value="Visualizza Database">
</form>
	
<form action="AdminPage.jsp">
	<input type="Submit" value="Modifica Database">
</form>
	


<div id="newsletter">
  <form method="POST" action="iscrizione">
    <label for="email">Iscriviti alla newsletter</label>
    <input type="email" id="email" name="email">
    <button type="submit"></button>
  </form>
</div>




<%@ include file="footer.html"  %>
</body>
</html>