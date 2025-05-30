<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Product.ProductDTO" %>
<%@ page import="model.ProductImage.ProductImageDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

<%
    List<ProductDTO> prodottiScontati = (List<ProductDTO>) request.getAttribute("scontati");
    List<ProductDTO> prodottiBestseller = (List<ProductDTO>) request.getAttribute("bestsellers");
    Map<Integer, ProductImageDTO> coverImages = (Map<Integer, ProductImageDTO>) request.getAttribute("coverImages");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>BuildItUp</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="css/style_index.css?v=<%= System.currentTimeMillis() %>">
    <link rel="stylesheet" href="./css/style_header.css?v=<%= System.currentTimeMillis() %>">
    <link rel="stylesheet" href="./css/style_footer.css?v=<%= System.currentTimeMillis() %>">
</head>

<body>
<div class="page-wrapper">
    <%@ include file="header.html" %>

    <main class="homepage">

        <% if (prodottiScontati != null && !prodottiScontati.isEmpty()) { %>
            <div id="discounts">
                <h1>Discounts</h1>
                <div class="products">
                    <%
					    for (ProductDTO product : prodottiScontati) {
					        ProductImageDTO cover = coverImages.get(product.getId());
					%>
    				<div class="product-card">
        				<% if (cover != null) { %>
            				<img src="image?id=<%= cover.getId() %>" alt="Immagine di copertina">
        				<% } else { %>
            				<img src="img/default.jpg" alt="Nessuna immagine disponibile">
        				<% } %>
        				<h3><%= product.getName() %></h3>
        				<h3 class="discount"><%= String.format("%.2f",product.getDiscount()*100) %>%</h3>
    				</div>
					<%
    					}
					%>
                </div>
                <div class="view-all">
                    <a class="out" href="CatalogViewer?type=discounts">View All</a>
                </div>
            </div>
        <% } %>

        <% if (prodottiBestseller != null && !prodottiBestseller.isEmpty()) { %>
            <div id="bestsellers">
                <h1>Best Sellers</h1>
                <div class="products">
                    <%
					    for (ProductDTO product : prodottiBestseller) {
					        ProductImageDTO cover = coverImages.get(product.getId());
					%>
    				<div class="product-card">
        				<% if (cover != null) { %>
            				<img src="image?id=<%= cover.getId() %>" alt="Immagine di copertina">
        				<% } else { %>
            				<img src="img/default.jpg" alt="Nessuna immagine disponibile">
        				<% } %>
        				<h3><%= product.getName() %></h3>
        				<h3><%= product.getPrice() %>€</h3>
    				</div>
					<%
    					}
					%>
                </div>
                <div class="view-all">
                    <a class="out" href="CatalogViewer?type=bestsellers">View All</a>
                </div>
            </div>
        <% } %>

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

    <%@ include file="footer.html" %>
</div>
</body>
</html>