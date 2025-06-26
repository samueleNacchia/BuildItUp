<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Siamo - Build It Up</title>
    <style>
    
    	html{
    		display:none;
    	}
    
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #333;
            background-color: #f9f9f9;
        }
        
        
        .about-hero {
		    background: linear-gradient(135deg, #1e1e1e, #3e3e3e);
		    color: white;
		    text-align: center;
		    padding: 15px 15px;
		    display: flex;
		    flex-direction: column;
		    justify-content: center;  
		    align-items: center;      
		    min-height: 150px;        
		}



        .about-hero h1 {
            font-size: 2em;
            margin-bottom: 10px;
        }
        
        
        .about-hero p {
            font-size: 1.2em;
            max-width: 800px;
            margin: auto;
        }
        
        
        
        .about-content {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            padding: 50px 20px;
            max-width: 1500px;
            margin: auto;
            align-items: center;
        }
        
        
        
        .about-text h2 {
            color: #1e1e1e;
            font-size: 2em;
            margin-bottom: 15px;
        }
        
        
        .about-text p {
            line-height: 1.8;
            font-size: 1.1em;
        }
        
        
        
        .about-content img {
		    width: 100%;
		    max-width: 500px;        
		    display: block;
		    margin: 0 auto;           
		}
		
        
        @media (max-width: 768px) {
		    .about-content {
		        grid-template-columns: 1fr;    
		        text-align: center;
		    }
		    .about-content img {
		        margin-top: 20px;             
		    }
		}
		
		

    </style>
</head>
<body>
	<%@ include file="header.jsp" %>
	
	<br><br>

    <section class="about-hero">
        <h1>La Passione Diventa Potenza</h1>
        <p>Dal gaming estremo ai setup professionali: noi di Build It Up trasformiamo ogni tua idea in performance reale.</p>
    </section>

    <section class="about-content">
        <div class="about-text">
            <h2>Chi Siamo</h2>
            <p>
                Build It Up nasce dall'incontro di passione e competenza nel mondo dell'hardware. Siamo un team di veri appassionati di tecnologia, gamer, e system builder con anni di esperienza nel settore. Ogni componente che trovi nel nostro shop è scelto con cura, testato e consigliato come se fosse destinato al nostro PC personale.
            </p>
            <p>
                Offriamo una selezione aggiornata dei migliori brand: schede video, processori, RAM, storage e tanto altro. E non ci fermiamo alla vendita: offriamo supporto tecnico, configurazioni personalizzate e guide all'assemblaggio.
            </p>
            <p>
                La nostra missione? Aiutarti a costruire la macchina dei tuoi sogni. Dal budget build al mostro da gaming 4K: abbiamo quello che fa per te.
            </p>
        </div>
        <div id="immagine">
            <img src="../images/about.png" alt="Componenti PC di alta qualità">
        </div>
    </section>



	<script>
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
	  
	  
	</script>
	<%@ include file="footer.jsp" %>
</body>
</html>
