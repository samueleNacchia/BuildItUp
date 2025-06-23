function toggleSection(id) {
        const section = document.getElementById(id);
        section.style.display = (section.style.display === "none") ? "block" : "none";
        if (section === document.getElementById("dati-personali"))
            document.getElementById("storico-ordini").style.display = "none";
        else if (section === document.getElementById("storico-ordini"))
            document.getElementById("dati-personali").style.display = "none";
    }

    function hideSections() {
        document.getElementById("dati-personali").style.display = "none";
        document.getElementById("storico-ordini").style.display = "none";
    }