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