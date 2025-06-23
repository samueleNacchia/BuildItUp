window.addEventListener("load", function() {
	document.documentElement.style.display = "block";
});
		        
		        
function showToast(message) {
	const toast = document.getElementById("toast");
	toast.textContent = message;
	toast.className = "toast show";
	setTimeout(() => {toast.className = "toast";}, 3000);
		        }
