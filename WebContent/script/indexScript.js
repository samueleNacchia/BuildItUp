window.addEventListener("load", function() {
    document.documentElement.style.display = "block";
	
	
	function resetError(id) {
	  	  	      document.getElementById(id + "Error").textContent = "";
	  	  	  }

	  	  	  function validateEmail() {
	  	  	      const email = document.getElementById("email").value.trim();
	  	  	      resetError("email");
	  	  	      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	  	  	      if (!emailRegex.test(email)) {
	  	  	          document.getElementById("emailError").textContent = "Inserisci un'email valida.";
	  	  	          return false;
	  	  	      }
	  	  	      return true;
	  	  	  }
			  
			  
			  
			  document.getElementById("email").addEventListener("blur", validateEmail);

	  	  	  
  });
  
  
  
  