(function () {
    "use strict";

    const LANG_KEY = "leh_language";

    const LANGUAGES = {
        en: {
            name: "English",
            native: "English",
            dir: "ltr"
        },
        ur: {
            name: "Urdu",
            native: "\u0627\u0631\u062F\u0648",
            dir: "rtl"
        },
        ar: {
            name: "Arabic",
            native: "\u0627\u0644\u0639\u0631\u0628\u064A\u0629",
            dir: "rtl"
        },
        nl: {
            name: "Dutch",
            native: "Nederlands",
            dir: "ltr"
        }
    };

    function getLanguage() {
        const saved = localStorage.getItem(LANG_KEY);
        return LANGUAGES[saved] ? saved : "ur";
    }

    function applyDirection(lang) {
        const item = LANGUAGES[lang] || LANGUAGES.en;

        document.documentElement.lang = lang;
        document.documentElement.dir = item.dir;

        document.body.classList.toggle(
            "leh-rtl",
            item.dir === "rtl"
        );
    }

    async function loadLanguage(lang) {
        if (!LANGUAGES[lang]) {
            lang = getLanguage();
        }

        localStorage.setItem(LANG_KEY, lang);
        localStorage.setItem("language", lang);
        localStorage.setItem("leh_lang", lang);

        applyDirection(lang);

        try {
            const response = await fetch(
                "/translations/" + lang + ".json",
                { cache: "no-cache" }
            );

            if (response.ok) {
                const translations = await response.json();

                document
                    .querySelectorAll("[data-i18n], [data-key]")
                    .forEach(function (element) {
                        const key =
                            element.getAttribute("data-i18n") ||
                            element.getAttribute("data-key");

                        if (
                            key &&
                            Object.prototype.hasOwnProperty.call(
                                translations,
                                key
                            )
                        ) {
                            element.textContent = translations[key];
                        }
                    });
            }
        } catch (error) {
            console.warn(
                "LearnEarnHub language fallback:",
                error.message
            );
        }

        updateSelector(lang);

        return lang;
    }

    function updateSelector(lang) {
        const item = LANGUAGES[lang] || LANGUAGES.en;

        document
            .querySelectorAll(".leh-language-current")
            .forEach(function (element) {
                element.textContent = item.native;
            });

        document
            .querySelectorAll(".leh-language-option")
            .forEach(function (button) {
                const active =
                    button.dataset.lang === lang;

                button.classList.toggle("active", active);
                button.setAttribute(
                    "aria-pressed",
                    active ? "true" : "false"
                );
            });
    }

    function setLanguage(lang) {
        return loadLanguage(lang);
    }

    function createSelector() {
        if (
            !document.body ||
            document.getElementById("leh-header-language")
        ) {
            return;
        }

        const wrapper = document.createElement("div");

        wrapper.id = "leh-header-language";
        wrapper.className = "leh-language";

        wrapper.innerHTML =
            '<button type="button" class="leh-language-toggle" aria-label="Choose language" aria-expanded="false"><span class="leh-language-icon" aria-hidden="true">🌐</span><span class="leh-language-current">English</span></button>' +

            '<div class="leh-language-menu" role="menu">' +

            '<button type="button" class="leh-language-option" ' +
            'data-lang="en" role="menuitem">' +
            ' English' +
            '</button>' +

            '<button type="button" class="leh-language-option" ' +
            'data-lang="ur" role="menuitem">' +
            ' \u0627\u0631\u062F\u0648' +
            '</button>' +

            '<button type="button" class="leh-language-option" ' +
            'data-lang="ar" role="menuitem">' +
            ' \u0627\u0644\u0639\u0631\u0628\u064A\u0629' +
            '</button>' +

            '<button type="button" class="leh-language-option" ' +
            'data-lang="nl" role="menuitem">' +
            ' Nederlands' +
            '</button>' +

            '</div>';

        const target =
            document.querySelector(".leh-nav") ||
            document.querySelector(".leh-header") ||
            document.querySelector(".nav-actions") ||
            document.querySelector(".nav") ||
            document.querySelector(".site-header");

        if (target) {
            target.prepend(wrapper);
        }

        const toggle =
            wrapper.querySelector(".leh-language-toggle");

        toggle.addEventListener("click", function () {
            const open =
                wrapper.classList.toggle("open");

            toggle.setAttribute(
                "aria-expanded",
                open ? "true" : "false"
            );
        });

        wrapper
            .querySelectorAll(".leh-language-option")
            .forEach(function (button) {

                button.addEventListener(
                    "click",
                    function () {
                        setLanguage(button.dataset.lang);

                        wrapper.classList.remove("open");

                        toggle.setAttribute(
                            "aria-expanded",
                            "false"
                        );
                    }
                );
            });

        document.addEventListener(
            "click",
            function (event) {
                if (!wrapper.contains(event.target)) {
                    wrapper.classList.remove("open");

                    toggle.setAttribute(
                        "aria-expanded",
                        "false"
                    );
                }
            }
        );

        updateSelector(getLanguage());
    }

    window.LEHLanguage = {
        languages: LANGUAGES,
        getLanguage: getLanguage,
        loadLanguage: loadLanguage,
        setLanguage: setLanguage,
        createSelector: createSelector
    };

    window.setLanguage = setLanguage;
    window.loadLanguage = loadLanguage;
    window.createSelector = createSelector;

    document.addEventListener(
        "DOMContentLoaded",
        function () {
            createSelector();
            loadLanguage(getLanguage());
        }
    );
})();






