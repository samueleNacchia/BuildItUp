<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.ItemList.ItemListDTO" %>
<%@ page import="model.Product.ProductDTO" %>

<%
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
                <tr>
                    <th>Nome</th>
                	<th>Prezzo</th>
                	<th>Immagine</th>
                    <%
                        if (type.equals("cart")) {
                    %>	
                	<th>Quantità</th>
                    <%
                        }
                    %>
                    <th>Azioni</th>
                </tr>
          
                <%	
                	ProductDTO product = new ProductDTO();
      
                    for (ItemListDTO item : items) {
                    	product = item.getProduct();
                    	float price = product.getPrice() * (1 - product.getDiscount());
                    	
                %>
                <tr>
                    <td><%= product.getName() %></td>
                    <td><%= String.format("%.2f", price) %></td>
                    <td>
                    	<!--<a href="Product?id=x"> -->
                    	<img src="<%= request.getContextPath() %>/image?id=<%= product.getId() %>&n=1" >
             			<!-- </a> -->
                    </td>
                    
                    
                    <%if (type.equals("cart")) { %>
                    <td><%= item.getQuantity() %></td>
                    <% } %>
                    
                    <td>
                    <% if (type.equals("cart")) { %>
                    
                    <a href="AddToList?type=<%=type%>&id=<%=product.getId()%>" style="text-decoration: none;  ">
  					<input type="submit" value="+">
					</a>
                    <% } %>
                    
                    <a href="DeleteFromList?type=<%=type%>&id=<%=product.getId()%>" style="text-decoration: none;  ">
  					<input type="submit" value="-" style="background-color: red;">
					</a>
					</td>
                    
                </tr>
                <%
                    }
                %>
        </table>
         <% if (type.equals("cart")) { %>
  			<a href="GetList?type=<%=type%>&to=checkout" style="text-decoration: none;">
  				<input type="submit" value="Acquista">
			</a>
			
       <% } %>
    <%
        }
    %>
    
</body>
</html>