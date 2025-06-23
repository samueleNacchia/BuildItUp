window.addEventListener("load", function () {
    const slides = document.querySelectorAll(".swiper-slide");
    const slideCount = slides.length;

    if (slideCount === 0) return; // Niente da inizializzare

    const swiper = new Swiper(".mySwiper", {
        loop: slideCount >= 3,
        allowTouchMove: slideCount > 1,
        navigation: slideCount > 1 ? {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev"
        } : false,
        pagination: {
            el: ".swiper-pagination",
            clickable: true
        },
        slidesPerView: 1,
        spaceBetween: 10
    });
});

function changeQty(delta) {
    const input = document.getElementById("quantity");
    let current = parseInt(input.value);
    const max = parseInt(input.max);
    if (isNaN(current)) current = 1;
    let newValue = Math.min(Math.max(1, current + delta), max);
    input.value = newValue;
}

function showToast(message, isError = false) {
    const toast = document.getElementById("toast");
    toast.textContent = message;

    toast.className = "toast show";

    if (isError) {
        toast.classList.add("error");
    } else {
        toast.classList.add("success");
    }

    setTimeout(() => {
        toast.className = "toast";
    }, 3000);
}

