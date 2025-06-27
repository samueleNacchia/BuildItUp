<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_header.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"> 
<meta name="viewport" content="width=device-width, initial-scale=1.0">

 

<header class="tab">
   	<section class="tab-items">

   
    	<div class="burger-menu" id="burger-menu">
		  <i class="fa-solid fa-bars"></i>
		</div>


      	<div class="item title">
        	<span id="sl"><a href="${pageContext.request.contextPath}/common/Home" class="sl">Build It Up!</a>
        	</span>
      	</div>
      
      	<div class="item search">
        	<form action="${pageContext.request.contextPath}/common/CatalogViewer" method="get">
			  <input type="text" name="name" placeholder="Cerca prodotto" id="src"
			         value="${not empty name ? name : ''}" maxlength="50">
			</form>	
      	</div>
      
      	<nav class="item nav">
        	<a class="item-link" href="${pageContext.request.contextPath}/common/about.jsp">About Us</a>
        	<a class="item-link" href="${pageContext.request.contextPath}/common/contact.jsp">Contact</a>
      	</nav>
      
      	<div class="item icons">
      	<c:if test="${sessionScope.isAdmin != true}">
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
				  <c:when test="${sessionScope.isAdmin == true}">
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

<div class="mobile-menu-overlay" id="mobile-menu-overlay">
  <div class="mobile-menu-content">
    <a class="item-link" href="${pageContext.request.contextPath}/common/CatalogViewer?category=GPU">Schede grafiche</a>
    <a class="item-link" href="${pageContext.request.contextPath}/common/CatalogViewer?category=MOBO">Schede madri</a>
    <a class="item-link" href="${pageContext.request.contextPath}/common/CatalogViewer?category=CPU">Processori</a>
    <a class="item-link" href="${pageContext.request.contextPath}/common/CatalogViewer?category=COOLING">Raffreddamento</a>
    <a class="item-link" href="${pageContext.request.contextPath}/common/CatalogViewer?category=CASE">Case</a>
    <a class="item-link" href="${pageContext.request.contextPath}/common/CatalogViewer?category=PSU">Alimentatori</a>
    <a class="item-link" href="${pageContext.request.contextPath}/common/CatalogViewer?category=RAM">RAM</a>
    <a class="item-link" href="${pageContext.request.contextPath}/common/CatalogViewer?category=MEM">Archiviazione</a>
    <a class="item-link" href="${pageContext.request.contextPath}/common/CatalogViewer">Catalogo</a>
  </div>
</div>


  
<nav class="subheader">
   	<section class="subh-items">
      	<a class="item-link" href="${pageContext.request.contextPath}/common/CatalogViewer?category=GPU">Schede grafiche</a>
      	<a class="item-link" href="${pageContext.request.contextPath}/common/CatalogViewer?category=MOBO">Schede madri</a>
      	<a class="item-link" href="${pageContext.request.contextPath}/common/CatalogViewer?category=CPU">Processori</a>
      	<a class="item-link" href="${pageContext.request.contextPath}/common/CatalogViewer?category=COOLING">Raffreddamento</a>
      	<a class="item-link" href="${pageContext.request.contextPath}/common/CatalogViewer?category=CASE">Case</a>
      	<a class="item-link" href="${pageContext.request.contextPath}/common/CatalogViewer?category=PSU">Alimentatori</a>
      	<a class="item-link" href="${pageContext.request.contextPath}/common/CatalogViewer?category=RAM">RAM</a>
      	<a class="item-link" href="${pageContext.request.contextPath}/common/CatalogViewer?category=MEM">Archiviazione</a>
      	<a class="item-link" href="${pageContext.request.contextPath}/common/CatalogViewer">Catalogo</a>
  	</section>
</nav>

<script>
document.addEventListener('DOMContentLoaded', function() {
	  const burger = document.getElementById('burger-menu');  // Assicurati che il tuo burger abbia questo id
	  const overlay = document.getElementById('mobile-menu-overlay');

	  burger.addEventListener('click', function() {
	    overlay.classList.add('active');
	  });

	  overlay.addEventListener('click', function(event) {
	    if (event.target === overlay) {
	      overlay.classList.remove('active');
	    }
	  });
	});
  
  document.addEventListener('DOMContentLoaded', function() {
    const userIcon = document.getElementById('user-icon');
    const dropdown = userIcon.closest('.dropdown');

    userIcon.addEventListener('click', function(event) {
      event.stopPropagation();  // Previene chiusure accidentali
      dropdown.classList.toggle('open');
    });

    // Chiudi il dropdown se clicchi fuori
    document.addEventListener('click', function(event) {
      if (!dropdown.contains(event.target)) {
        dropdown.classList.remove('open');
      }
    });
  });
  
</script>
