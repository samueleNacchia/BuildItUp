/*LOADER*/

function loadAjaxRequest(url, method, params, cFunction) {
    const request = new XMLHttpRequest();

    request.onreadystatechange = function () {
        if (request.readyState === 4) {
            if (request.status === 200) {
                try {
                    const jsonResponse = JSON.parse(request.responseText);
                    cFunction(jsonResponse); 
                } catch (e) {
                    console.error("Errore nel parsing della risposta JSON.");
                    console.error(e);
                }
            } else if (request.status !== 0) {
                console.error("Errore nella richiesta: " + request.status + " - " + request.statusText);
            }
        }
    };

    setTimeout(() => {
        if (request.readyState < 4) {
            request.abort();
            console.error("La richiesta ha impiegato troppo tempo e è stata annullata.");
        }
    }, 15000);

    if (method.toUpperCase() === "GET") {
        const fullUrl = params ? `${url}?${params}` : url;
        request.open("GET", fullUrl, true); 
        request.send(null);
    } else if (method.toUpperCase() === "POST") {
        request.open("POST", url, true);
        request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        request.send(params);
    } else {
        console.error("Metodo HTTP non supportato: " + method);
    }
}


/*SEARCH ORDERS*/

function searchOrders() {
	const userId = document.getElementById("userId").value.trim();
	const fromDate = document.getElementById("fromDate").value;
	const toDate = document.getElementById("toDate").value;

	const params = `fromDate=${encodeURIComponent(fromDate)}&
					toDate=${encodeURIComponent(toDate)}&
					userId=${encodeURIComponent(userId)}`;
	
	loadAjaxRequest("GetOrdersJSON", "GET", params, function(response) {
	    UpdateOrdersTableJSON(response);
	});
}

function UpdateOrdersTableJSON(response) {
	
    if (response.success && response.functionName === "searchOrders") {
	
        const orders = response.orders;
        const tableBody = document.getElementById("order-table-body"); // tbody dentro la tabella
        tableBody.innerHTML = ""; // pulisce la tabella

        if (orders.length === 0) {
            tableBody.innerHTML = `<tr><td colspan="6">Nessun ordine trovato.</td></tr>`;
            return;
        }
		
		orders.forEach(order => {
		    const row = document.createElement("tr");
		    row.id = `order-${order.id}`;

		    const statuses = ["In_elaborazione", "Elaborato", "Spedito", "Consegnato", "Annullato"];
		    const optionsHtml = statuses.map(status => {
		        return `<option value="${status}"${order.status === status ? " selected" : ""}>${status}</option>`;
		    }).join("");

		    row.innerHTML = `
		        <td>${order.id}</td>
		        <td>${order.userId}</td>
		        <td>${order.orderDate}</td>
		        <td>
		            <select id="status-${order.id}" name="stato" onchange="updateStatus(${order.id})">
		                ${optionsHtml}
		            </select>
		        </td>
		    `;

		    tableBody.appendChild(row);
		});
	
    } else {
        console.error("Errore nel caricamento degli ordini.");
    }
}


function updateStatus(orderId) {
    const select = document.getElementById("status-" + orderId);
    if (!select) {
        console.error("Elemento select non trovato per l'ordine: " + orderId);
        return;
    }

    const newStatus = select.value;
    const params = "id=" + encodeURIComponent(orderId) + "&stato=" + encodeURIComponent(newStatus);

   	loadAjaxRequest("UpdateOrder", "GET", params, function(response) {
     	if (response.status && response.functionName === "updateStatus") {
          	console.log("Ordine aggiornato con successo");
        } else {
           	console.error("Errore durante l'aggiornamento dell'ordine");
       }   
    });
}



/*UPDATE ITEM LIST*/

function addToList(productId, type, quantity) {
    const params = `type=${encodeURIComponent(type)}&id=${encodeURIComponent(productId)}&quantity=${encodeURIComponent(quantity)}`;
    loadAjaxRequest("AddToList", "POST", params, function(response) {
        
		if (response.success) {
			
			showToast(`Prodotto aggiunto ${type === "cart" ? "al carrello" : "alla lista"}!`, false);
			
		} else {
		       
			console.log("Errore: " + (response.message || "Operazione fallita."));
	        showToast("Errore durante l'aggiunta.", true);
		}
		
    });
}

function addItem(productId, type) {
    const params = `type=${encodeURIComponent(type)}&id=${encodeURIComponent(productId)}`;
    loadAjaxRequest("AddToList", "GET", params, function(response) {
        UpdateQuantityJSON(response, productId);
    });
}

function deleteItem(productId, type) {
    const params = `type=${encodeURIComponent(type)}&id=${encodeURIComponent(productId)}`;
    loadAjaxRequest("DeleteFromList", "GET", params, function(response) {
        UpdateQuantityJSON(response, productId);
    });
}

function UpdateQuantityJSON(response, productId) {

    if (response.success && response.functionName === "UpdateQuantityJSON") {
        const quantityCell = document.getElementById("quantity-" + productId);
        const productRow = document.getElementById("product-" + productId);
        const table = document.getElementById("product-table");
        const emptyMessage = document.getElementById("empty-message");
        const btnCheckout = document.getElementById("btn-checkout");
        const btnDelete = document.getElementById("btn-delete-" + productId);

        if (quantityCell) {
            quantityCell.innerText = response.quantity;
            if (btnDelete) {
                btnDelete.innerText = response.quantity <= 1 ? "X" : "-";
            }
        }

        if (productRow && response.deleted) {
            productRow.remove();

            if (table && table.rows.length <= 1) { // Solo intestazione rimasta
                table.remove();
                if (emptyMessage) emptyMessage.style.display = "block";
                if (btnCheckout) btnCheckout.style.display = "none";
            }
        }
    }
}





