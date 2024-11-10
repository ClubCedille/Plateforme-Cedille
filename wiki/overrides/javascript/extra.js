document.addEventListener("DOMContentLoaded", function () {
    const languageLinks = document.querySelectorAll(".md-select__link");

    languageLinks.forEach(link => {
        link.addEventListener("click", function (event) {
            event.preventDefault();
            
            const newLang = this.getAttribute("hreflang");
            const currentPath = window.location.pathname;

            let newPath;
            if (currentPath.startsWith('/en') || currentPath.startsWith('/fr')) {
                newPath = currentPath.replace(/^\/(fr|en)/, newLang === 'fr' ? '' : `/${newLang}`);
            } else {
                newPath = newLang === 'fr' ? currentPath : `/${newLang}${currentPath}`;
            }

            newPath = newPath.replace(/\/{2,}/g, '/');

            const newUrl = `${window.location.origin}${newPath}`;
            console.log("Navigating to:", newUrl);
            window.location.href = newUrl;
        });
    });
});
