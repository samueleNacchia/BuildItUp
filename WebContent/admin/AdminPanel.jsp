<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Admin Panel</title>
    <style>html{display:none}</style>
    <%@ include file="headerAdmin.jsp" %>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/AdminPanel.css?v=<%= System.currentTimeMillis() %>" />
</head>
<body data-context-path="${pageContext.request.contextPath}">
	<div class="page-container">
		<main>
			<h1>Pannello di Amministrazione</h1>
	
			<h2>Inserisci Nuovo Prodotto</h2>
			<form action="AddProduct" method="post" enctype="multipart/form-data">
			    <label>Nome: <input type="text" name="nome" required /></label>
			    <label>Descrizione: <textarea name="descrizione"></textarea></label>
			    <label>Prezzo: <input type="number" name="prezzo" step="0.01" required /></label>
			    <label>Categoria:
			        <select name="categoria">
			            <option value="CPU" selected>CPU</option>
			            <option value="GPU">GPU</option>
			            <option value="MOBO">MOBO</option>
			            <option value="CASE">CASE</option>
			            <option value="COOLING">COOLING</option>
			            <option value="RAM">RAM</option>
			            <option value="MEM">MEM</option>
			            <option value="PSU">PSU</option>
			        </select>
			    </label>
			    <label>Disponibilità: <input type="number" name="stocks" min="0" step="1" required /></label>
			    <label>Immagine di copertina: <input type="file" name="copertina" id="fileInput1" accept="image/*" /></label>
			    <label>Altre Immagini: <input type="file" name="immagini" id="fileInput2" accept="image/*" multiple /></label>
			    <br />
			    <div class="button-container">
				    <button class="delete" type="reset">Reset</button>
				    <button class="delete" type="button" onclick="document.getElementById('fileInput1').value='';document.getElementById('fileInput2').value='';">Reset Immagini</button>
				    <input type="submit" class="add" value="Aggiungi Prodotto" />
				</div>
			</form>
			<c:choose>
				<c:when test="${not empty prodotti}">
					<h2 align="center">Prodotti in Catalogo</h2>
					<table >
					    <tr>
					        <th>Nome</th>
					        <th>Descrizione</th>
					        <th class="col">Prezzo</th>
					        <th class="col">Sconto</th>
					        <th class="col">In Vendita</th>
					        <th class="col">Quantità</th>
					        <th>Azioni</th>
					        <th class="images-column hidden-column">Immagini</th>
					    </tr>
					    
			            <c:forEach var="product" items="${prodotti}">
			                <tr>
			                    <form action="UpdateProduct" method="post">
			                        <input type="hidden" name="id" value="${product.id}" />
			                        <td>${product.name}<input type="hidden" name="name" value="${product.name}" /></td>
			                        <td><input type="text" name="descrizione" value="${product.description}" /></td>
			                        <td class ="rid"><input type="number" min="0" name="prezzo" value="${product.price}" step="0.01" /></td>
			                        <td class ="rid"><input type="number" max="1" min="0" name="sconto" value="${product.discount}" step="0.0001" /></td>
			                        <input type="hidden" name="category" value="${product.category}" />
			                        <td class ="rid">
			                            <input type="checkbox" name="inVendita" value="true" <c:if test="${product.onSale}">checked</c:if> />
			                        </td>
			                        <td class ="rid"><input type="number" name="stocks" min="0" value="${product.stocks}" step="1" /></td>
			                        <td>
			                            <input type="submit" class="update" value="Update" onclick="return confirm('Aggiornare ${product.name}?')" /> <br><br>
			                            <button type="button" onclick="toggleImages('${product.id}')" class="update">Espandi Immagini</button>
			                        </td>
			                    </form>
			
			                    <td class="images-column hidden-column" colspan="11">
			                        <div class = "hidden image-scroll-container" id="images-${product.id}">
			                            <c:forEach var="img" items="${immaginiPerProdotto[product.id]}">
			                                <form action="DeleteImage" method="post" style="display:inline">
			                                    <img src="${pageContext.request.contextPath}/image?id=${img.id}" height="100" />
			                                    <input type="hidden" name="imageId" value="${img.id}" />
			                                    <input type="submit" class="delete" value="X" onclick="return confirm('Eliminare questa immagine?')" />
			                                </form>
			                            </c:forEach>
			                            
			                            
			
			                            <form action="AddImages" method="post" enctype="multipart/form-data">
			                                <input type="hidden" name="productId" value="${product.id}" />
			                                <input type="file" name="copertina" id="cover" accept="image/*" />
			                                <button class="delete" type="reset">Reset Immagine</button>
			                                <input type="submit" class="add" value="Aggiungi Copertina" />
			                            </form>
			
			                            <form action="AddImages" method="post" enctype="multipart/form-data">
			                                <input type="hidden" name="productId" value="${product.id}" />
			                                <input type="file" name="immagini" accept="image/*" multiple />
			                                <button class="delete" type="reset">Reset Immagini</button>
			                                <input type="submit" class="add" value="Aggiungi immagini" />
			                            </form>
			                        </div>
			                    </td>
			                </tr>
			            </c:forEach>    
					</table>
				</c:when>
			    <c:otherwise>
			    	<h2>Nessun prodotto disponibile</h2>
			    </c:otherwise>
			</c:choose>
			
			<h2 align="center">Ordini</h2>
			
			<form onsubmit="event.preventDefault();">
			  	<label for="fromDate">Data inizio:</label>
			  	<input type="date" id="fromDate" onChange="searchOrders()" name="fromDate">
			
			  	<label for="toDate">Data fine:</label>
			  	<input type="date" id="toDate" onChange="searchOrders()" name="toDate">
			
			  	<label for="userId">ID Utente:</label>
			  	<input type="number" id="userId" onInput="searchOrders()" name="userId" placeholder="Es. 11">
			</form>
	
			
			    <c:choose>
			        <c:when test="${not empty ordini}">
						<table id="order-table" style="margin: auto;">
						    <thead>
						        <tr>
						            <th>ID Ordine</th>
						            <th>Cliente</th>
						            <th>Data</th>
						            <th>Stato</th>
						        </tr>
						   	</thead>
						    <tbody id="order-table-body">
							    <c:forEach var="order" items="${ordini}">
							            <tr id="order-${order.id}">
							                <td>${order.id}</td>
							                <td>${order.id_user}</td>
							                <td>${order.orderDateFormatted}</td>
							                <td>
												<c:set var="allStatuses" value="${fn:split('In_elaborazione,Elaborato,Spedito,Consegnato,Annullato', ',')}" />

												<c:forEach var="status" items="${allStatuses}" varStatus="loop">
												    <c:if test="${status == order.statusName}">
												        <c:set var="currentIndex" value="${loop.index}" />
												    </c:if>
												</c:forEach>
												
												<!-- Select con solo gli stati successivi o uguali allo stato corrente -->
												<select id="status-${order.id}" name="stato"
												        onChange="updateStatus(${order.id})"
												        <c:if test="${order.statusName == 'Annullato' || order.statusName == 'Consegnato'}">disabled</c:if>>
												    
												    <c:forEach var="status" items="${allStatuses}" varStatus="loop">
												        <c:if test="${loop.index >= currentIndex}">
												            <option value="${status}" <c:if test="${order.statusName == status}">selected</c:if>>
												                ${status}
												            </option>
												        </c:if>
												    </c:forEach>
												</select>
							                </td>
							            </tr>
							    </c:forEach>
							</tbody>
						</table>
			       	</c:when>
			  	<c:otherwise>
			    	<h2>Nessun ordine trovato</h2>
			   	</c:otherwise>
			</c:choose>
		
			
		</main>
	</div>
	
	<div id="toast" class="toast">Prodotto aggiunto!</div>
	
	<%@ include file="/common/footer.jsp" %>
	<script src ="${pageContext.request.contextPath}/script/adminPanelScript.js"></script>


<script src="${pageContext.request.contextPath}/script/AJAX.js?v=<%= System.currentTimeMillis() %>"></script>

</body>
</html>