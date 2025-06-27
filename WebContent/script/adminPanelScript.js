window.addEventListener("load", function() {
	document.documentElement.style.display = "block";
});
		        
		        
function showToast(message) {
	const toast = document.getElementById("toast");
	toast.textContent = message;
	toast.className = "toast show";
	setTimeout(() => {toast.className = "toast";}, 3000);
		        }
				document.addEventListener("DOMContentLoaded", function () {

				    // Controllo form inserimento nuovo prodotto
				    const addForm = document.querySelector('form[action="AddProduct"]');
				    if (addForm) {
				        addForm.addEventListener("submit", function (e) {
				            const prezzo = addForm.querySelector('input[name="prezzo"]').value.trim();
				            const stocks = addForm.querySelector('input[name="stocks"]').value.trim();

				            if (prezzo < 0 || isNaN(prezzo)) {
				                alert("Il prezzo deve essere un numero positivo.");
				                e.preventDefault();
				                return;
				            }

				            if (!/^\d+$/.test(stocks) || stocks < 0) {
				                alert("La quantità deve essere un intero positivo.");
				                e.preventDefault();
				                return;
				            }
				        });
				    }

				    // Controllo su tutti i form di aggiornamento prodotti
				    const updateForms = document.querySelectorAll('form[action="UpdateProduct"]');
				    updateForms.forEach(form => {
				        form.addEventListener("submit", function (e) {
				            const prezzo = form.querySelector('input[name="prezzo"]').value.trim();
				            const sconto = form.querySelector('input[name="sconto"]').value.trim();
				            const stocks = form.querySelector('input[name="stocks"]').value.trim();

				            if (prezzo < 0 || isNaN(prezzo)) {
				                alert("Il prezzo deve essere un numero positivo.");
				                e.preventDefault();
				                return;
				            }

				            if (sconto < 0 || sconto > 1 || isNaN(sconto) || !/^\d*(\.\d{1,4})?$/.test(sconto)) {
				                alert("Lo sconto deve essere un numero tra 0 e 1, con massimo 4 cifre decimali.");
				                e.preventDefault();
				                return;
				            }

				            if (!/^\d+$/.test(stocks) || stocks < 0) {
				                alert("La quantità deve essere un intero positivo.");
				                e.preventDefault();
				                return;
				            }
				        });
				    });

				    // Blocco digitazione errata in tempo reale per nuovo prodotto
				    const prezzoInput = document.querySelector('input[name="prezzo"]');
				    const stocksInput = document.querySelector('input[name="stocks"]');

				    if (prezzoInput) {
				        prezzoInput.addEventListener("input", function () {
				            if (this.value < 0) this.value = 0;
				        });
				    }

				    if (stocksInput) {
				        stocksInput.addEventListener("input", function () {
				            this.value = this.value.replace(/[^\d]/g, "");
				        });
				    }

				    // Blocco digitazione per ogni riga di tabella esistente
				    document.querySelectorAll('input[name="prezzo"]').forEach(input => {
				        input.addEventListener("input", function () {
				            if (this.value < 0) this.value = 0;
				        });
				    });

				    document.querySelectorAll('input[name="sconto"]').forEach(input => {
				        input.addEventListener("input", function () {
				            if (this.value < 0) this.value = 0;
				            if (this.value > 1) this.value = 1;
				            const parts = this.value.split('.');
				            if (parts[1] && parts[1].length > 4) {
				                parts[1] = parts[1].substring(0, 4);
				                this.value = parts.join('.');
				            }
				        });
				    });

				    document.querySelectorAll('input[name="stocks"]').forEach(input => {
				        input.addEventListener("input", function () {
				            this.value = this.value.replace(/[^\d]/g, "");
				        });
				    });

				});
				
				
				
				
				let imagesColumnVisible = false;

				                function toggleImages(productId) {
				                    const imageDiv = document.getElementById('images-' + productId);
				                    const row = document.getElementById('row-' + productId);
				                    const allRows = document.querySelectorAll('.images-column');
				                    const imagesHeader = document.getElementById('images-header');

				                    if (!imageDiv || !row) return;

				                    // Toggle visibilità della sezione immagini
				                    imageDiv.classList.toggle('hidden');

				                    // Mostra tutte le righe immagini se almeno una è attiva
				                    if (!imagesColumnVisible) {
				                        allRows.forEach(r => r.classList.remove('hidden-column'));
				                        if (imagesHeader) imagesHeader.classList.remove('hidden-column');
				                        imagesColumnVisible = true;
				                    }

				                    // Se tutte le sezioni immagini sono nascoste, nascondi anche le righe
				                    const anyVisible = [...document.querySelectorAll('.images-section')].some(el => !el.classList.contains('hidden'));
				                    if (!anyVisible) {
				                        allRows.forEach(r => r.classList.add('hidden-column'));
				                        if (imagesHeader) imagesHeader.classList.add('hidden-column');
				                        imagesColumnVisible = false;
				                    }
				                }
	
	
			
				
