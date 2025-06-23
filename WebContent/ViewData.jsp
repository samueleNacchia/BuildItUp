<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Product-Users</title>
    <style>html{display:none}</style>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/StyleView.css?v=<%= System.currentTimeMillis() %>">
</head>
<body>
	<a href="../common/Home">Home</a>

	<h1>Utenti</h1>
	
    <c:if test="${not empty utenti}">
        <table>
            <tr>
                <th>Codice</th>
                <th>Email</th>
                <th>Password</th>
                <th>Nome</th>
                <th>Surname</th>
                <th>Via</th>
                <th>Civico</th>
                <th>CAP</th>
                <th>tel</th>
            </tr>
            <c:forEach var="utente" items="${utenti}">
                <tr>
                    <td>${utente.id}</td>
                    <td>${utente.email}</td>
                    <td>${utente.password}</td>
                    <td><${utente.name}</td>
                    <td>${utente.surname}</td>
                    <td>${utente.via}</td>
                    <td>${utente.roadNum}</td>
                    <td>${utente.postalCode}</td>
                    <td>${utente.tel}</td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
       
    <h1>Admin</h1>
	
    <c:if test="${not empty admin}">
        <table>
            <tr>
                <th>Email</th>
                <th>Password</th>
            </tr>
            <c:forEach var="admin" items="${admin}">
                <tr>
                    <td>${admin.email}</td>
                    <td>${admin.password}</td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
    
    
    
    
    <h1>Prodotti</h1>
	
     <c:if test="${not empty prodotti}">
        <table>
            <tr>
                 <th>Codice</th>
                <th>Nome</th>
                <th>Categoria</th>
                <th>Descrizione</th>
                <th>Prezzo</th>
                <th>Sconto (%)</th>
                <th>InVendita</th>
                <th>Quantità</th>
            </tr>
            <c:forEach var="prodotto" items="${prodotti}">
                <tr>
                    <td>${prodotto.id}</td>
                    <td>${prodotto.name}</td>
                    <td>${prodotto.category}</td>
                    <td>${prodotto.description}</td>
                    <td>${prodotto.price}</td>
                    <td>${prodotto.discount}</td>
                    <td>${prodotto.onSale}</td>
                    <td>${prodotto.stocks}</td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
    
    
    <h1>Immagini</h1>
	
    <c:if test="${not empty image}">
        <table>
            <tr>
                <th>Codice</th>
                <th>Id Prodotto</th>
                <th>Immagine</th>
            </tr>
            <c:forEach var="image" items="${image}">
                <tr>
                    <td>${image.id}</td>
                    <td>${image.idProduct}</td>
                    <td><img src="image?id=${image.id}"></td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
    

    <h1>Ordini</h1>
    
     <c:if test="${not empty ordini}">
        <table>
            <tr>
                <th>Codice</th>
                <th>Utente</th>
                <th>Data</th>
                <th>Stato</th>
            </tr>
            <c:forEach var="ordine" items="${ordini}">
                <tr>
                    <td>${ordine.id}</td>
                    <td>${ordine.id_user}</td>
                    <td>${ordine.orderDateFormatted}</td>
                    <td>${ordine.status}</td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
    
    
    <h1>ProdottiOrdine</h1>
    
    <c:if test="${not empty prodottiOrdinati}">
        <table>
            <tr>
                <th>Codice Prodotto</th>
                <th>Codice Ordine</th>
                <th>Prezzo</th>
                <th>Quantità</th>
            </tr>
            <c:forEach var="prodottoOrdine" items="${prodottiOrdinati}">
                <tr>
                    <td>${prodottoOrdine.id_product}</td>
                    <td>${prodottoOrdine.id_order}</td>
                    <td>${prodottoOrdine.price} €</td>
                    <td>${prodottoOrdine.quantity}</td>
                </tr>
            </c:forEach>
        </table>
	</c:if>
    
    
    
    <h1>Recensioni</h1>
	
	
	<c:if test="${not empty recensioniProdotto}">
        <table>
            <tr>
               	<th>Codice utente</th>
                <th>Codice prodotto</th>
                <th>Testo</th>
                <th>Voto</th>
                <th>Data</th>
            </tr>
            <c:forEach var="recensione" items="${recensioniProdotto}">
                <tr>
                    <td>${recensione.id_user}</td>
                    <td>${recensione.id_product}</td>
                    <td>${recensione.text}</td>
                    <td>${recensione.vote}</td>
                    <td>${recensione.reviewDateFormatted}</td>
                </tr>
            </c:forEach>
        </table>
	</c:if>
   
    
    <h1>Fatture</h1>
	
	
	<c:if test="${not empty fatture}">
        <table>
            <tr>
               	<th>Codice ordine</th>
                <th>Totale</th>
                <th>Data</th>
            </tr>
            <c:forEach var="fattura" items="${fatture}">
                <tr>
                    <td>${fattura.id_order}</td>
                    <td>${fattura.total} €</td>
                    <td>${fattura.billDateFormatted}</td>
                </tr>
            </c:forEach>
        </table>
	</c:if>
    
    <h1>Newsletter</h1>
	
	
	<c:if test="${not empty news}">
        <table>
            <tr><th>Email</th></tr>
            <c:forEach var="newsletter" items="${news}">
                <tr><td>${newsletter.email}</td></tr>
            </c:forEach>
        </table>
	</c:if>
    
    
    <h1>Liste</h1>
	
	<c:if test="${not empty liste}">
        <table>
            <tr>
               	<th>Codice</th>
                <th>Token</th>
                <th>Codice utente</th>
                <th>Tipologia</th>
                <th>Ultimo accesso</th>
            </tr>
            <c:forEach var="lista" items="${liste}">
                <tr>
                    <td>${lista.id}</td>
                    <td>${lista.token}</td>
                    <td>${lista.id_user}</td>
                    <td>${lista.type}</td>
                    <td>${lista.lastAccess}</td>
                </tr>
            </c:forEach>
        </table>
	</c:if>
    
    
    
    <h1>Item delle liste</h1>
	
	<c:if test="${not empty items}">
        <table>
            <tr>
               	<th>Codice lista</th>
                <th>Codice prodotto</th>
                <th>Quantità</th>
            </tr>
            <c:forEach var="item" items="${items}">
                <tr>
                    <td>${item.id_list}</td>
                    <td>${item.id_product}</td>
                    <td>${item.quantity}</td>
                </tr>
            </c:forEach>
        </table>
	</c:if>
	
	
	<script src="<%= request.getContextPath()%>/script/indexScript.jsp">
	</script>  
</body>
</html>