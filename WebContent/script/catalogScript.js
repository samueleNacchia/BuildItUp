

window.addEventListener("load", function () {
    document.documentElement.style.display = "block";

    const slider = document.getElementById('price-slider');
    if (!slider) return;

    const minInput = document.getElementById('minPrice');
    const maxInput = document.getElementById('maxPrice');
    const form = slider.closest('form');

    const minPrice = parseInt(slider.getAttribute('data-min'));
    // const maxPriceFromData = parseInt(slider.getAttribute('data-max')); // NON usato più

    const maxVisual = 1000; // massimo visibile sempre 1000

    let maxPriceRaw = maxInput.value; // valore reale inviato, es. "1000" o ""

    // Se maxPriceRaw è "1000", lo consideriamo "nessun limite" (campo vuoto)
    if (maxPriceRaw === '1000') {
        maxPriceRaw = '';
        maxInput.value = '';
    }

    noUiSlider.create(slider, {
        start: [minPrice, maxPriceRaw !== '' ? parseInt(maxPriceRaw) : maxVisual], // usa valore reale se presente, altrimenti maxVisual
        connect: true,
        range: {
            'min': minPrice,
            'max': maxVisual
        },
        step: 10,
        tooltips: [true, true],
        format: {
            to: value => Math.round(value),
            from: value => parseInt(value)
        }
    });

    slider.noUiSlider.on('update', function (values) {
        const min = values[0];
        const max = values[1];
        minInput.value = min;

        // Se max è uguale al massimo visibile e l’utente non ha mosso il cursore,
        // campo vuoto per indicare nessun limite
        if (max === maxVisual && maxPriceRaw === '') {
            maxInput.value = '';
        } else {
            maxInput.value = max;
        }
    });
	
	const toggleButton = document.querySelector('.filter-toggle-btn');
	const filterPanel = document.querySelector('.filter-bar-horizontal');

	if (toggleButton && filterPanel) {
		    toggleButton.addEventListener('click', function() {
		        filterPanel.classList.toggle('open');
		    });

		    // Questo serve per chiudere cliccando fuori
		    document.addEventListener('click', function(event) {
		        if (filterPanel.classList.contains('open') &&
		            !filterPanel.contains(event.target) &&
		            !toggleButton.contains(event.target)) {
		            filterPanel.classList.remove('open');
		        }
		    });
		}
});



