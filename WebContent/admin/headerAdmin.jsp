<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_header.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">  
<header class="tab">
   	<section class="tab-items">
      	
      	<div class="item title">
            <span id="sl"><a href="${pageContext.request.contextPath}/common/Home" class="sl">Build It Up!</a>
        	</span>
      	</div>
      
      	<div class="item search">
        	<form action="${pageContext.request.contextPath}/admin/AdminPanelServlet" method="get">
			  <input type="text" name="name" placeholder="Cerca prodotto" id="src"
			         value="${not empty name ? name : ''}" maxlength="50">
			</form>
      	</div>
      
      	<nav class="item nav">
        	<a class="item-link" href="${pageContext.request.contextPath}/common/about.jsp">About Us</a>
        	<a class="item-link" href="${pageContext.request.contextPath}/common/contact.jsp">Contact</a>
      	</nav>
      
      	<div class="item icons">
        	
		
			<div class="dropdown">
				  <i class="fa-solid fa-user" id="user-icon" style="font-size: 35px; color: dimgray; cursor: pointer;"></i>
				  <div class="dropdown-content">
				  <a href="${pageContext.request.contextPath}/admin/AdminPanelServlet">Admin Panel</a>
				    <a href="${pageContext.request.contextPath}/common/logout">Logout</a>	
     	 		</div>
      		</div>
  	</section>
</header>

<div class="mobile-menu-overlay" id="mobile-menu-overlay">
  <div class="mobile-menu-content">
    <a class="item-link" href="${pageContext.request.contextPath}/admin/AdminPanelServlet?category=GPU">Schede grafiche</a>
      	<a class="item-link" href="${pageContext.request.contextPath}/admin/AdminPanelServlet?category=MOBO">Schede madri</a>
      	<a class="item-link" href="${pageContext.request.contextPath}/admin/AdminPanelServlet?category=CPU">Processori</a>
      	<a class="item-link" href="${pageContext.request.contextPath}/admin/AdminPanelServlet?category=COOLING">Raffreddamento</a>
      	<a class="item-link" href="${pageContext.request.contextPath}/admin/AdminPanelServlet?category=CASE">Case</a>
      	<a class="item-link" href="${pageContext.request.contextPath}/admin/AdminPanelServlet?category=PSU">Alimentatori</a>
      	<a class="item-link" href="${pageContext.request.contextPath}/admin/AdminPanelServlet?category=RAM">RAM</a>
      	<a class="item-link" href="${pageContext.request.contextPath}/admin/AdminPanelServlet?category=MEM">Archiviazione</a>
      	<a class="item-link" href="${pageContext.request.contextPath}/admin/AdminPanelServlet">Catalogo</a>
  </div>
</div>
  
<nav class="subheader">
   	<section class="subh-items">
   	  
    	<a class="item-link" href="${pageContext.request.contextPath}/admin/AdminPanelServlet?category=GPU">Schede grafiche</a>
      	<a class="item-link" href="${pageContext.request.contextPath}/admin/AdminPanelServlet?category=MOBO">Schede madri</a>
      	<a class="item-link" href="${pageContext.request.contextPath}/admin/AdminPanelServlet?category=CPU">Processori</a>
      	<a class="item-link" href="${pageContext.request.contextPath}/admin/AdminPanelServlet?category=COOLING">Raffreddamento</a>
      	<a class="item-link" href="${pageContext.request.contextPath}/admin/AdminPanelServlet?category=CASE">Case</a>
      	<a class="item-link" href="${pageContext.request.contextPath}/admin/AdminPanelServlet?category=PSU">Alimentatori</a>
      	<a class="item-link" href="${pageContext.request.contextPath}/admin/AdminPanelServlet?category=RAM">RAM</a>
      	<a class="item-link" href="${pageContext.request.contextPath}/admin/AdminPanelServlet?category=MEM">Archiviazione</a>
      	<a class="item-link" href="${pageContext.request.contextPath}/admin/AdminPanelServlet">Catalogo</a>
  	</section>
</nav>