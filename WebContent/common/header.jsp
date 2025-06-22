<link rel="stylesheet" href="../css/style_header.css?">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">  

<header class="tab">
   	<section class="tab-items">
   
    	<div class="item logo">
        	<img src="../images/logo.png" id="logo">
      	</div>
      
      	<div class="item title">
        	<span id="sl"><a href="${pageContext.request.contextPath}/common/Home" class="sl">Build It Up!</a>
        	</span>
      	</div>
      
      	<div class="item search">
        <!-- PER UTENTI	-->
        	<form action="CatalogViewer" method="get">
        <!-- PER ADMIN -->
        	<!--
        	<form action="AdminPanelServlet" method="get">
        	-->
          		<input type="text" name="name" placeholder="Cerca prodotto" id="src">
        	</form>
        	
      	</div>
      
      	<nav class="item nav">
        	<a class="item-link" href="#">About Us</a>
        	<a class="item-link" href="#">Contact</a>
      	</nav>
      
      	<div class="item icons">
      	<c:if test="${sessionScope.ruolo != 1}">
        	<a href="${pageContext.request.contextPath}/unlogged/GetList?type=wishlist" style="text-decoration: none;  ">
		  		<i class="fa-solid fa-heart" id="wishlist-icon" style="font-size: 35px; color: dimgray;"></i>
			</a>
		
        	<a href="${pageContext.request.contextPath}/unlogged/GetList?type=cart" style="text-decoration: none; cursor: pointer;">
		  		<i class="fa-solid fa-shopping-cart" id="cart-icon" style="font-size: 35px; color: dimgray"></i>
			</a>
			</c:if>
			<div class="dropdown">
				  <i class="fa-solid fa-user" id="user-icon" style="font-size: 35px; color: dimgray; cursor: pointer;"></i>
				  <div class="dropdown-content">
				   <c:choose>
				  <c:when test="${sessionScope.ruolo == 1}">
				    <a href="${pageContext.request.contextPath}/admin/AdminPanelServlet">Admin Panel</a>
				    <a href="${pageContext.request.contextPath}/common/logout">Logout</a>
				  </c:when>
				
				  <c:when test="${not empty sessionScope.id}">
				    <a href="${pageContext.request.contextPath}/user/MyProfile">Profilo</a>
				    <a href="${pageContext.request.contextPath}/common/logout">Logout</a>
				  </c:when>
				
				  <c:otherwise>
				    <a href="${pageContext.request.contextPath}/common/LogIn_page.jsp">Login</a>
				    <a href="${pageContext.request.contextPath}/common/Register_page.jsp">Registrati</a>
				  </c:otherwise>
				</c:choose>


				  </div>
				</div>
	
      	</div>
      
  	</section>
</header>
  
<nav class="subheader">
   	<section class="subh-items">
   	<!-- PER UTENTI -->
      	<a class="item-link" href="${pageContext.request.contextPath}/common/CatalogViewer?category=GPU">Schede grafiche</a>
      	<a class="item-link" href="${pageContext.request.contextPath}/common/CatalogViewer?category=MOBO">Schede madri</a>
      	<a class="item-link" href="${pageContext.request.contextPath}/common/CatalogViewer?category=CPU">Processori</a>
      	<a class="item-link" href="${pageContext.request.contextPath}/common/CatalogViewer?category=COOLING">Raffreddamento</a>
      	<a class="item-link" href="${pageContext.request.contextPath}/common/CatalogViewer?category=CASE">Case</a>
      	<a class="item-link" href="${pageContext.request.contextPath}/common/CatalogViewer?category=PSU">Alimentatori</a>
      	<a class="item-link" href="${pageContext.request.contextPath}/common/CatalogViewer?category=RAM">RAM</a>
      	<a class="item-link" href="${pageContext.request.contextPath}/common/CatalogViewer?category=MEM">Memorie di massa</a>
      	<a class="item-link" href="${pageContext.request.contextPath}/common/CatalogViewer">Catalogo</a>
    	
    <!-- PER ADMIN -->
    <!--  
    	<a class="item-link" href="AdminPanelServlet?category=GPU">Schede grafiche</a>
      	<a class="item-link" href="AdminPanelServlet?category=MOBO">Schede madri</a>
      	<a class="item-link" href="AdminPanelServlet?category=CPU">Processori</a>
      	<a class="item-link" href="AdminPanelServlet?category=COOLING">Raffreddamento</a>
      	<a class="item-link" href="AdminPanelServlet?category=CASE">Case</a>
      	<a class="item-link" href="AdminPanelServlet?category=PSU">Alimentatori</a>
      	<a class="item-link" href="AdminPanelServlet?category=RAM">RAM</a>
      	<a class="item-link" href="AdminPanelServlet?category=MEM">Memorie di massa</a>
      	<a class="item-link" href="AdminPanelServlet">Catalogo</a>
    -->
  	</section>
</nav>