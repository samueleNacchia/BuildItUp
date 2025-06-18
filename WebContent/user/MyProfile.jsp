	<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
	<%@ page import="model.User.*" %>
	<%@ page import="model.Order.*" %>
	<%@ page import="model.Product.*" %>
	<%@ page import="model.Bill.*" %>
	<%@ page import="model.ProductOrder.*" %>
	<%@ page import="java.util.ArrayList" %>
	<%@ page import="java.util.List" %>
	<%@ page import="java.sql.SQLException" %>
	
	<%	
		
	 	UserDAO userDAO = new UserDAO();
		
		UserDTO user = userDAO.findByCode((int)session.getAttribute("id"));
	    OrderDAO orderDAO = new OrderDAO();
		List<OrderDTO> ordini = orderDAO.findByUserCode(user.getId());
	    BillDAO billDAO = new BillDAO(); // DAO per recuperare il totale da Bills
	    ProductOrderDAO pOrderDAO = new ProductOrderDAO(); // Per recuperare la lista prodotti 
		ProductDAO pDAO = new ProductDAO ();
	%>
	
	<!DOCTYPE html>
	<html>
	<head>
	    <meta charset="UTF-8">
	    <title>My Profile</title>
	    <link rel="stylesheet" type="text/css" href="../css/MyProfileStyle.css">
	    <link rel="stylesheet" href="../css/style_header.css?v=<%= System.currentTimeMillis() %>">
	    <link rel="stylesheet" href="../css/style_footer.css?v=<%= System.currentTimeMillis() %>">
	 
	 
	    <script>
	        function toggleSection(id) {
	            const section = document.getElementById(id);
	            section.style.display = (section.style.display === "none") ? "block" : "none";
	        	if (section == document.getElementById("dati-personali"))
	        		document.getElementById("storico-ordini").style.display = "none";
	        	else if (section == document.getElementById("storico-ordini"))
	                document.getElementById("dati-personali").style.display = "none";
	        }
	
	        function hideSections() {
	            document.getElementById("dati-personali").style.display = "none";
	            document.getElementById("storico-ordini").style.display = "none";
	        }
	    </script>
	</head>
	<body>
	<div class="page-wrapper">
		
	    <%@ include file="/header.html" %>
	   
	   <div class="content">
	    <h1>Benvenuto, <%= user.getName() %> !</h1>
	
			<div class="button-row">
		    	<button class="b" onclick="toggleSection('dati-personali')">Dati Personali</button>
		   		<button class="b" onclick="toggleSection('storico-ordini')">Storico Ordini</button>
		   		<button class="b" onclick="hideSections()">Nascondi</button>
			</div>
		    
		    <div class ="dati-personali" id="dati-personali" style="display:none;">
		        <h2>Dati Personali</h2>
		        <p><strong>Email:</strong> <%= user.getEmail() %></p>
		        <p><strong>Nome:</strong>  <%= user.getName() %></p>
		        <p><strong>Cognome:</strong> <%= user.getSurname() %></p>
		        <p><strong>Telefono:</strong> <%= user.getTel() %></p>
		        <p><strong>Indirizzo:</strong> <%= user.getVia() %>, <%= user.getRoadNum() %> - <%= user.getPostalCode()%> - <%= user.getProvincia() %></p>
		        
		        <form class ="update" action="../UpdateAddressServlet" method="post">
		            <h3>Aggiorna indirizzo</h3>
		            <input type="text" name="ind" value="<%= user.getVia() %>" required><br>
		            <input type="text" name="civ" value="<%= user.getRoadNum()%>" required><br>
		            <input type="text" name="cap" value="<%= user.getPostalCode()%>" required><br>
		             <input type="text" name="prov" value=" <%= user.getProvincia() %>" required><br>
		            <input type="submit" value="Aggiorna indirizzo">
		        </form>
		    </div>
		
		    <div id="storico-ordini" style="display:none;">
	    <h2>Storico Ordini</h2>
	    <% if (ordini != null) {
	           for (OrderDTO ordine : ordini) { 
	               BillDTO bill = null;
	               try {
	                   bill = billDAO.findByOrder(ordine.getId());
	               } catch (SQLException e) {
	                   e.printStackTrace(System.out);
	               }
	    %>
	    <div class="ordine-box">
	        <details>
	        <form action="<%= request.getContextPath() %>/cancelOrder" method="post">
    <input type="hidden" name="orderId" value="<%= ordine.getId() %>">
    <% if ("In_elaborazione".equals(ordine.getStatus().toString()) || "Elaborato".equals(ordine.getStatus().toString())) { %>
        <p Style="text-indent : 1.5em"> <button class="cancel"type="submit">Annulla Ordine</button> </p>
    <% } %>
</form>
	            <summary>
	            <%
    String statoFormattato = ordine.getStatus().toString().replace("_", " ");
    statoFormattato = statoFormattato.substring(0, 1).toUpperCase() + statoFormattato.substring(1).toLowerCase();
%>
				    <strong>Ordine #<%= ordine.getId() %></strong> 
				    Stato: <%= statoFormattato %><br>
				    <p Style="text-indent : 1.1em">Pagato il: <%= bill != null ? bill.getBillDate() : "N/A" %>  -
				    Totale: €<%= bill != null ? String.format("%.2f", bill.getTotal()) : "0.00" %> </p>
				</summary>
	            <%
	                int id = ordine.getId();
	                List<ProductOrderDTO> productsOrder = pOrderDAO.findAllforOrder(id);
	                ProductDTO product =null;
	                for (ProductOrderDTO pr : productsOrder) {
	                    product = pDAO.findByCode(pr.getId_product());
	            %>
	            <div class="product-item">
	                <img class="product-image" 
	                     src="ViewImage?id=<%= pr.getId_product() %>" 
	                     alt="<%= product.getName() %>" 
	                     width="100" height="100">
	                <div class="product-info">
	                    <p ><strong>Nome: <a href="${pageContext.request.contextPath}/productDetails?id=<%= product.getId()%> " style="text-decoration: none; color: #000000; font-size: 1.1em"> <%= product.getName() %> </a></strong> </p>
	                    <p><strong>ID:</strong> <%= pr.getId_product() %></p>
	                    <p><strong>Prezzo:</strong> €<%= pr.getPrice() %></p>
	                    <p><strong>Quantità:</strong> <%= pr.getQuantity() %></p>
	                    <p><strong>Totale prodotto:</strong> €<%= pr.getPrice()*pr.getQuantity() %></p>
	                    
	                    
	                </div>
	            </div>
	            <%
	                } // fine ciclo prodotti
	            %>
	        </details>
	    </div>
	    <% 
	           }
	           }
	    %>
	</div>
	</div>
		<%@ include file="../footer.html" %>
	          
	
	</body>
	</html>
