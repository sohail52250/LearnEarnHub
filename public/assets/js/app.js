document.addEventListener("DOMContentLoaded", () => {
    const year = document.querySelector("[data-year]");

    if (year) {
        year.textContent = new Date().getFullYear();
    }

    const menu = document.querySelector("[data-menu]");
    const nav = document.querySelector("[data-nav]");

    if (menu && nav) {
        menu.addEventListener("click", () => {
            nav.classList.toggle("open");
        });
    }
});
