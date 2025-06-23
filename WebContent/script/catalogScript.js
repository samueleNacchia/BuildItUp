window.addEventListener("load", function () {
    document.documentElement.style.display = "block";

    const slider = document.getElementById('price-slider');
    const minInput = document.getElementById('minPrice');
    const maxInput = document.getElementById('maxPrice');

    // Recupera i valori dai data-attribute
    const minPrice = parseInt(slider.getAttribute('data-min'));
    const maxPrice = parseInt(slider.getAttribute('data-max'));

    noUiSlider.create(slider, {
        start: [minPrice, maxPrice], 
        connect: true,
        range: {
            'min': 0,
            'max': 1000
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
        maxInput.value = max;
    });
});
