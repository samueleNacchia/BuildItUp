<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_footer.css?v=<%= System.currentTimeMillis() %>" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="${pageContext.request.contextPath}/script/footerScript.js"></script>


</script>
<footer class="main">
    <section class="items">
      

      <div class="item logo">
        <img src="./images/logo.png" id="logo">
      </div>

      <article>
        <section id="usrArea">
          <h3>Area Personale</h3>
          <nav>
            <a class="item-links" href="${pageContext.request.contextPath}/common/LogIn_page.jsp">Accedi</a><br>
            <a class="item-links" href="${pageContext.request.contextPath}/common/Register_page.jsp">Registrati</a>
          </nav>
        </section>
      </article>

      <div class="separator" aria-hidden="true"></div>

      <article>
        <section id="legal">
          <h3>Informazioni e extras</h3>
          <nav>
            <a class="item-links" href="${pageContext.request.contextPath}/common/about.jsp">About us</a><br>
            <a class="item-links" href="${pageContext.request.contextPath}/common/contact.jsp">Contact</a><br>
          </nav>
        </section>
      </article>

    </section>
 
  </footer>