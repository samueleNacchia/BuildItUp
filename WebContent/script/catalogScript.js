window.addEventListener("load", function () {
    document.documentElement.style.display = "block";

    const slider = document.getElementById('price-slider');
    if (!slider) return;

    const minInput = document.getElementById('minPrice');
    const maxInput = document.getElementById('maxPrice');

    const maxVisual = 1000;

    let minValueRaw = minInput.value;
    let maxValueRaw = maxInput.value;

    if (maxValueRaw === '1000') {
        maxValueRaw = '';
        maxInput.value = '';
    }

    const minStart = minValueRaw !== '' ? parseInt(minValueRaw) : 0;
    const maxStart = maxValueRaw !== '' ? parseInt(maxValueRaw) : maxVisual;

    noUiSlider.create(slider, {
        start: [minStart, maxStart],
        connect: true,
        range: {
            'min': 0,
            'max': maxVisual
        },
        step: 10,
        tooltips: [
            {
                to: value => Math.round(value),
                from: value => parseInt(value)
            },
            {
                to: value => value === maxVisual ? 'max' : Math.round(value),
                from: value => value === 'max' ? maxVisual : parseInt(value)
            }
        ],
        format: {
            to: value => value,
            from: value => value
        }
    });

    slider.noUiSlider.on('update', function (values, handle, unencoded) {
        const min = Math.round(unencoded[0]);
        const max = Math.round(unencoded[1]);

        minInput.value = min;

        if (max === maxVisual) {
            maxInput.value = '';
        } else {
            maxInput.value = max;
        }
    });

    const toggleButton = document.querySelector('.filter-toggle-btn');
    const filterPanel = document.querySelector('.filter-bar-horizontal');

    if (toggleButton && filterPanel) {
        toggleButton.addEventListener('click', function () {
            filterPanel.classList.toggle('open');
        });

        document.addEventListener('click', function (event) {
            if (filterPanel.classList.contains('open') &&
                !filterPanel.contains(event.target) &&
                !toggleButton.contains(event.target)) {
                filterPanel.classList.remove('open');
            }
        });
    }
});