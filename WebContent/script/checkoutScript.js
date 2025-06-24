	document.addEventListener('DOMContentLoaded', function () {
	
	  function resetError(fieldId) {
	    const errorElem = document.getElementById(fieldId + "Error");
	    if (errorElem) errorElem.textContent = "";
	  }
	
	  function validateInd() {
	    if (addressFields.style.display === 'none') return true;
	    const ind = document.getElementById("street").value.trim();
	    resetError("street");
	    if (ind.length < 3) {
	      document.getElementById("streetError").textContent = "Inserisci un indirizzo valido.";
	      return false;
	    }
	    return true;
	  }
	
	  function validateCiv() {
	    if (addressFields.style.display === 'none') return true;
	    const civ = document.getElementById("civic").value.trim();
	    resetError("civic");
	    if (!/^\d+$/.test(civ)) {
	      document.getElementById("civicError").textContent = "Inserisci un numero civico valido.";
	      return false;
	    }
	    return true;
	  }
	
	  function validateCap() {
	    if (addressFields.style.display === 'none') return true;
	    const cap = document.getElementById("zip").value.trim();
	    resetError("zip");
	    if (!/^\d{5}$/.test(cap)) {
	      document.getElementById("zipError").textContent = "Inserisci un CAP valido di 5 cifre.";
	      return false;
	    }
	    return true;
	  }
	
	  function validateProv() {
	    if (addressFields.style.display === 'none') return true;
	    const prov = document.getElementById("province").value.trim();
	    resetError("province");
	    if (!/^[A-Z]{2}$/.test(prov)) {
	      document.getElementById("provinceError").textContent = "Inserisci una provincia valida (2 lettere maiuscole).";
	      return false;
	    }
	    return true;
	  }
	
	  function validateCardNumber() {
	    const number = document.getElementById('cardNumber').value.replace(/\s/g, '');
	    resetError('cardNumber');
	    if (!/^\d{16}$/.test(number)) {
	      document.getElementById('cardNumberError').textContent = 'Numero carta non valido. Deve contenere 16 cifre.';
	      return false;
	    }
	    return true;
	  }
	
	  function validateExpiry() {
	    const expiry = document.getElementById('expiry').value.trim();
	    resetError('expiry');
	    const match = expiry.match(/^(0[1-9]|1[0-2])\/\d{2}$/);
	    if (!match) {
	      document.getElementById('expiryError').textContent = 'Inserisci una data valida (MM/AA).';
	      return false;
	    }
	    return true;
	  }
	
	  function validateCvv() {
	    const cvv = document.getElementById('cvv').value.trim();
	    resetError('cvv');
	    if (!/^\d{3,4}$/.test(cvv)) {
	      document.getElementById('cvvError').textContent = 'Il CVV deve essere di 3 o 4 cifre.';
	      return false;
	    }
	    return true;
	  }
	
	  function formatCardNumber(value) {
	    return value.replace(/\D/g, '').replace(/(.{4})/g, '$1 ').trim();
	  }
	
	  function validateCardForm() {
	    let valid = true;
	    if (!validateCardNumber()) valid = false;
	    if (!validateExpiry()) valid = false;
	    if (!validateCvv()) valid = false;
	    return valid;
	  }
	
	  function validateAll() {
	    let valid = true;
	    if (!validateInd()) valid = false;
	    if (!validateCiv()) valid = false;
	    if (!validateCap()) valid = false;
	    if (!validateProv()) valid = false;
	    if (!validateCardForm()) valid = false;
	    return valid;
	  }
	
	  const initialAddressValues = {};
	
	  ['street', 'civic', 'zip', 'province'].forEach(function (id) {
	    const el = document.getElementById(id);
	    if (el) {
	      initialAddressValues[id] = el.value;
	    }
	  });
	
	  const editBtn = document.getElementById('editAddressBtn');
	  const addressFields = document.getElementById('addressFields');
	
	  editBtn.addEventListener('click', function () {
	    if (addressFields.style.display === 'block') {
	      // Chiudo modifica
	      addressFields.style.display = 'none';
	      this.textContent = 'Modifica Indirizzo';
	      ['street', 'civic', 'zip', 'province'].forEach(function (id) {
	        const el = document.getElementById(id);
	        if (el) {
	          el.value = initialAddressValues[id] || '';  // riporto valore iniziale
	          resetError(id);
	        }
	      });
	    } else {
	      // Apro modifica
	      addressFields.style.display = 'block';
	      this.textContent = 'Annulla Modifica';
	    }
	  });
	
	  const cardInput = document.getElementById('cardNumber');
	  const expiryInput = document.getElementById('expiry');
	  const cvvInput = document.getElementById('cvv');
	
	  if (cardInput) {
	    cardInput.addEventListener('input', function () {
	      this.value = formatCardNumber(this.value);
	    });
	    cardInput.addEventListener('keypress', function (e) {
	      if (!/\d/.test(e.key)) e.preventDefault();
	    });
	    cardInput.addEventListener('blur', validateCardNumber);
	  }
	
	  if (expiryInput) {
	    expiryInput.addEventListener('input', function (e) {
	      let value = this.value.replace(/\D/g, '');
	      if (value.length > 2) {
	        value = value.substring(0, 2) + '/' + value.substring(2);
	      }
	      this.value = value;
	    });
	
	    expiryInput.addEventListener('keypress', function (e) {
	      if (!/\d/.test(e.key)) e.preventDefault();
	    });
	
	    expiryInput.addEventListener('blur', validateExpiry);
	  }
	
	  if (cvvInput) {
	    cvvInput.addEventListener('keypress', function (e) {
	      if (!/\d/.test(e.key)) e.preventDefault();
	    });
	    cvvInput.addEventListener('blur', validateCvv);
	  }
	
	  const form = document.querySelector('form');
	  if (form) {
	    form.addEventListener('submit', function (e) {
	      if (!validateAll()) {
	        e.preventDefault();
	      }
	    });
	  }
	
	});
