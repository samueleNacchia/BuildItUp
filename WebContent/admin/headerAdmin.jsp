<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_header.css?v=<%= System.currentTimeMillis() %>">
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
			         value="${not empty name ? name : ''}">
			</form>
      	</div>
      
      	<nav class="item nav">
        	<a class="item-link" href="#">About Us</a>
        	<a class="item-link" href="#">Contact</a>
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
  
<nav class="subheader">
   	<section class="subh-items">
   	  
    	<a class="item-link" href="AdminPanelServlet?category=GPU">Schede grafiche</a>
      	<a class="item-link" href="AdminPanelServlet?category=MOBO">Schede madri</a>
      	<a class="item-link" href="AdminPanelServlet?category=CPU">Processori</a>
      	<a class="item-link" href="AdminPanelServlet?category=COOLING">Raffreddamento</a>
      	<a class="item-link" href="AdminPanelServlet?category=CASE">Case</a>
      	<a class="item-link" href="AdminPanelServlet?category=PSU">Alimentatori</a>
      	<a class="item-link" href="AdminPanelServlet?category=RAM">RAM</a>
      	<a class="item-link" href="AdminPanelServlet?category=MEM">Archiviazione</a>
      	<a class="item-link" href="AdminPanelServlet">Catalogo</a>
  	</section>
</nav>