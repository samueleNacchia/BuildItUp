document.addEventListener("DOMContentLoaded", function () {
    const btn = document.createElement("button");
    btn.id = "scrollToTopBtn";
    btn.title = "Torna su";
    btn.innerText = "top";
    
    Object.assign(btn.style, {
        display : "none",
        position: "fixed",
        bottom: "40px",
        right: "30px",
        zIndex: "100",
        fontSize: "24px",
        backgroundColor: "#297678",
        color: "white",
        border: "none",
        borderRadius: "50%",
        padding: "10px 15px",
        cursor: "pointer",
        boxShadow: "0px 4px 8px rgba(0,0,0,0.2)",
        transition: "background-color 0.3s ease"
    });

    btn.addEventListener("mouseover", () => btn.style.backgroundColor = "#1c5254");
    btn.addEventListener("mouseout", () => btn.style.backgroundColor = "#297678");
    btn.addEventListener("click", () => {
        window.scrollTo({ top: 0, behavior: 'smooth' });
    });

    document.body.appendChild(btn);

    window.addEventListener("scroll", function () {
        btn.style.display = (window.scrollY > 100) ? "block" : "none";
    });
});
