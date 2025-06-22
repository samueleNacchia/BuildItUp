<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registrazione</title>
    <link rel="stylesheet" href="../css/Register_style.css">
    <link rel="stylesheet" href="./css/style_header.css?v=<%= System.currentTimeMillis() %>">
    <link rel="stylesheet" href="./css/style_footer.css?v=<%= System.currentTimeMillis() %>">
    
</head>
<body>
<div class="page-wrapper">
    <%@ include file="../common/header.jsp" %>
    <div class="register-container">
        <h2>Registrazione</h2>

        <%
            String error = request.getParameter("error");
            if ("pwd".equals(error)) {
        %>
            <div class="error-top"> ⚠️ Le password non corrispondono. Riprova.</div>
        <%
            }
        %>
                <%
            if ("dupe".equals(error)) {
        %>
            <div class="error-top"> ⚠️ L'email è già registrata. Riprova.</div>
        <%
            }
        %>

 <form id="registerForm" action="register" method="post" novalidate>

    <label>Email:</label>
    <input type="email" id="email" name="email" placeholder="example@gmail.com" required>
    <div class="error" id="emailError"></div>

    <label>Password:</label>
    <input type="password" id="password" name="password" placeholder="password" required>
    <div class="error" id="passwordError"></div>

    <label>Conferma Password:</label>
    <input type="password" id="confirm" name="confirm" placeholder="Confirm password" required>
    <div class="error" id="confirmError"></div>

    <label>Nome:</label>
    <input type="text" id="nome" name="nome" placeholder="Francesco" required>
    <div class="error" id="nomeError"></div>

    <label>Cognome:</label>
    <input type="text" id="cognome" name="cognome" placeholder="Totti" required>
    <div class="error" id="cognomeError"></div>

    <label>Cellulare:</label>
    <input type="text" id="cell" name="cell" placeholder="012 345 6789" required>
    <div class="error" id="cellError"></div>

    <label>Indirizzo:</label>
    <input type="text" id="ind" name="ind" placeholder="Via Roma" required>
    <div class="error" id="indError"></div>

    <label>Civico:</label>
    <input type="text" id="civ" name="civ" placeholder="1" required>
    <div class="error" id="civError"></div>

    <label>CAP:</label>
    <input type="text" id="cap" name="cap" placeholder="84001" required>
    <div class="error" id="capError"></div>

    <label>Provincia:</label>
    <input type="text" id="prov" name="prov" placeholder="SA" required>
    <div class="error" id="provError"></div>

    <button class ="reg"type="submit">Registrati</button>
</form>
        <form action="../common/LogIn_page.jsp" method="get">
            <button type="submit" class="log">Torna al Login</button>
        </form><script>
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

function validatePassword() {
    const password = document.getElementById("password").value.trim();
    resetError("password");
    if (password.length < 6) {
        document.getElementById("passwordError").textContent = "La password deve contenere almeno 6 caratteri.";
        return false;
    }
    return true;
}

function validateConfirm() {
    const password = document.getElementById("password").value.trim();
    const confirm = document.getElementById("confirm").value.trim();
    resetError("confirm");
    if (confirm !== password) {
        document.getElementById("confirmError").textContent = "Le password non corrispondono.";
        return false;
    }
    return true;
}

function validateNome() {
    const nome = document.getElementById("nome").value.trim();
    resetError("nome");
    if (nome.length < 2 || !/^[A-Za-zÀ-ÖØ-öø-ÿ]+$/.test(nome)) {
        document.getElementById("nomeError").textContent = "Inserisci un nome valido (solo lettere).";
        return false;
    }
    return true;
}

function validateCognome() {
    const cognome = document.getElementById("cognome").value.trim();
    resetError("cognome");

    // Regex: lettere (anche accentate), spazi, apostrofi, trattini
    const regex = /^[A-Za-zÀ-ÖØ-öø-ÿ' -]{2,50}$/;

    if (cognome.length < 2 || !regex.test(cognome)) {
        document.getElementById("cognomeError").textContent = "Inserisci un cognome valido (solo lettere e spazi).";
        return false;
    }
    return true;
}

function validateCell() {
    const cell = document.getElementById("cell").value.trim();
    resetError("cell");
    if (!/^[0-9\s]+$/.test(cell) || cell.length < 6) {
        document.getElementById("cellError").textContent = "Inserisci un numero di cellulare valido.";
        return false;
    }
    return true;
}

function validateInd() {
    const ind = document.getElementById("ind").value.trim();
    resetError("ind");
    if (ind.length < 3) {
        document.getElementById("indError").textContent = "Inserisci un indirizzo valido.";
        return false;
    }
    return true;
}

function validateCiv() {
    const civ = document.getElementById("civ").value.trim();
    resetError("civ");
    if (!/^\d+$/.test(civ)) {
        document.getElementById("civError").textContent = "Inserisci un numero civico valido.";
        return false;
    }
    return true;
}

function validateCap() {
    const cap = document.getElementById("cap").value.trim();
    resetError("cap");
    if (!/^\d{5}$/.test(cap)) {
        document.getElementById("capError").textContent = "Inserisci un CAP valido di 5 cifre.";
        return false;
    }
    return true;
}

function validateProv() {
    const prov = document.getElementById("prov").value.trim();
    resetError("prov");
    if (!/^[A-Z]{2}$/.test(prov)) {
        document.getElementById("provError").textContent = "Inserisci una provincia valida (2 lettere maiuscole).";
        return false;
    }
    return true;
}

// Colleghiamo gli eventi onBlur ai campi
document.getElementById("email").addEventListener("blur", validateEmail);
document.getElementById("password").addEventListener("blur", validatePassword);
document.getElementById("confirm").addEventListener("blur", validateConfirm);
document.getElementById("nome").addEventListener("blur", validateNome);
document.getElementById("cognome").addEventListener("blur", validateCognome);
document.getElementById("cell").addEventListener("blur", validateCell);
document.getElementById("ind").addEventListener("blur", validateInd);
document.getElementById("civ").addEventListener("blur", validateCiv);
document.getElementById("cap").addEventListener("blur", validateCap);
document.getElementById("prov").addEventListener("blur", validateProv);

// Validazione finale al submit per sicurezza
document.getElementById("registerForm").addEventListener("submit", function(e) {
    if (!(validateEmail() & validatePassword() & validateConfirm() & validateNome() &
          validateCognome() & validateCell() & validateInd() & validateCiv() &
          validateCap() & validateProv())) {
        e.preventDefault();
    }
});
</script>

        
        
    </div>
      <%@ include file="../common/footer.html" %>
</div>



</body>
</html>
