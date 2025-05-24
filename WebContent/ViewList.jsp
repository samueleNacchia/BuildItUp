<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.ItemList.ItemListDTO" %>
<%@ page import="model.Product.ProductDTO" %>

<%
	/*
	In questa pagina dovrebbe arrivare la lista di prodotti non di item!!
	*/

    //Prendo la lista di item passata dalla servlet
    List<ItemListDTO> items = (List<ItemListDTO>) request.getAttribute("items");
    String type = request.getParameter("type"); // "cart" oppure "wishlist"
%>

<!DOCTYPE html>
<html>
<head>
    <title>
    <%
    String titolo;
    if (type.equals("cart")) 
        titolo = "Carrello";
    else 
        titolo = "Wishlist";
	%>
	</title>
	<link rel="stylesheet" href="css/StyleView.css?v=<%= System.currentTimeMillis() %>">  
</head>
<body>
<a href="index.html">Home</a>

    <%
    String text = "Wishlist";
    if (type.equals("cart")) {
        titolo = "Carrello";
    }
	%>

<h1><%= titolo %></h1></h1>
    
    <%
        if (items == null || items.isEmpty()) {
    		
    			if (type.equals("cart")){ 
        			%><p>Il carrello è vuoto</p><%;
    			} else if(type.equals("wishlist")){
        			%><p>La wishlist è vuota</p><%;
    			} else{
        			%><p>La lista è vuota</p><%;
        		}
    	
        } else {
    %>
        <table>
            <thead>
                <tr>
                    <th>Codice prodotto</th>
                    <th>Nome</th>
                	<th>Categoria</th>
                	<th>Descrizione</th>
                	<th>Prezzo</th>
                	<th>Sconto (%)</th>
                	<th>InVendita</th>
                	<th>Img1</th>
                	<th>Img2</th>
                	<th>Img3</th>
                    <%
                        if (type.equals("cart")) {
                    %>	
                	<th>Quantità</th>
                    <%
                        }
                    %>
                </tr>
            </thead>
            <tbody>
                <%	
                	ProductDTO product = new ProductDTO();
      
                    for (ItemListDTO item : items) {
                    	product = item.getProduct();
                    	
                %>
                <tr>
                    <td><%= item.getId_product()%></td>
                    <td><%= product.getName()%></td>
                    <td><%= product.getCategory().name()%></td>
                    <td><%= product.getDescription()%></td>
                    <td><%= product.getPrice()%></td>
                    <td><%= product.getDiscount()%></td>
                    <td><%= product.isOnSale()%></td>
                    <td>
                    	<!--<a href="Product?id=x"> -->
                    	<img src="<%= request.getContextPath() %>/image?id=<%= product.getId() %>&n=1" >
             			<!-- </a> -->
                    </td>
                    <%
                        if (type.equals("cart")) {
                    %>
                    <td><%= item.getQuantity() %></td>
                    <%
                        }
                    %>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    <%
        }
    %>
    
</body>
</html>