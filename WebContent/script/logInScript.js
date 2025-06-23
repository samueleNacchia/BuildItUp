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
    if (password.length === 0) {
        document.getElementById("passwordError").textContent = "Inserisci una password.";
        return false;
    }
    return true;
}

// Collega gli eventi onBlur
document.getElementById("email").addEventListener("blur", validateEmail);
document.getElementById("password").addEventListener("blur", validatePassword);

// Validazione al submit per sicurezza
document.getElementById("loginForm").addEventListener("submit", function (e) {
    if (!(validateEmail() & validatePassword())) {
        e.preventDefault();
    }
});