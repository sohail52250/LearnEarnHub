/*!
 * LearnEarnHub Universal Button Icon Engine
 * UI-only. Does not modify authentication routes.
 */

(function () {
    "use strict";

    const ICONS = {
        login: `
            <path d="M10 17l5-5-5-5"></path>
            <path d="M15 12H3"></path>
            <path d="M21 19V5a2 2 0 0 0-2-2h-6"></path>
        `,
        logout: `
            <path d="M10 17l5-5-5-5"></path>
            <path d="M15 12H3"></path>
            <path d="M21 19V5a2 2 0 0 0-2-2h-6"></path>
        `,
        register: `
            <circle cx="12" cy="8" r="4"></circle>
            <path d="M4 21a8 8 0 0 1 16 0"></path>
            <path d="M19 8v6"></path>
            <path d="M16 11h6"></path>
        `,
        save: `
            <path d="M5 4h11l3 3v13H5z"></path>
            <path d="M8 4v6h8V4"></path>
            <path d="M8 20v-6h8v6"></path>
        `,
        edit: `
            <path d="M12 20h9"></path>
            <path d="M16.5 3.5a2.1 2.1 0 0 1 3 3L8 18l-4 1 1-4z"></path>
        `,
        delete: `
            <path d="M3 6h18"></path>
            <path d="M8 6V4h8v2"></path>
            <path d="M19 6l-1 14H6L5 6"></path>
            <path d="M10 11v5"></path>
            <path d="M14 11v5"></path>
        `,
        search: `
            <circle cx="11" cy="11" r="7"></circle>
            <path d="M20 20l-4-4"></path>
        `,
        filter: `
            <path d="M4 6h16"></path>
            <path d="M7 12h10"></path>
            <path d="M10 18h4"></path>
        `,
        add: `
            <path d="M12 5v14"></path>
            <path d="M5 12h14"></path>
        `,
        plus: `
            <path d="M12 5v14"></path>
            <path d="M5 12h14"></path>
        `,
        close: `
            <path d="M6 6l12 12"></path>
            <path d="M18 6L6 18"></path>
        `,
        back: `
            <path d="M19 12H5"></path>
            <path d="M12 19l-7-7 7-7"></path>
        `,
        next: `
            <path d="M5 12h14"></path>
            <path d="M12 5l7 7-7 7"></path>
        `,
        continue: `
            <path d="M5 12h14"></path>
            <path d="M12 5l7 7-7 7"></path>
        `,
        check: `
            <path d="M20 6L9 17l-5-5"></path>
        `,
        verify: `
            <path d="M12 3l7 3v5c0 4.5-3 8-7 10-4-2-7-5.5-7-10V6z"></path>
            <path d="M9 12l2 2 4-4"></path>
        `,
        apply: `
            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
            <path d="M14 2v6h6"></path>
            <path d="M8 13h8"></path>
            <path d="M8 17h5"></path>
        `,
        upload: `
            <path d="M12 16V4"></path>
            <path d="M7 9l5-5 5 5"></path>
            <path d="M5 20h14"></path>
        `,
        download: `
            <path d="M12 4v12"></path>
            <path d="M7 11l5 5 5-5"></path>
            <path d="M5 20h14"></path>
        `,
        refresh: `
            <path d="M20 11a8 8 0 0 0-14.9-3"></path>
            <path d="M4 4v4h4"></path>
            <path d="M4 13a8 8 0 0 0 14.9 3"></path>
            <path d="M20 20v-4h-4"></path>
        `,
        settings: `
            <circle cx="12" cy="12" r="3"></circle>
            <path d="M19.4 15a1.7 1.7 0 0 0 .3 1.9l.1.1-1.8 1.8-.1-.1a1.7 1.7 0 0 0-1.9-.3 1.7 1.7 0 0 0-1 1.6v.2h-2.6V20a1.7 1.7 0 0 0-1-1.6 1.7 1.7 0 0 0-1.9.3l-.1.1-1.8-1.8.1-.1A1.7 1.7 0 0 0 8 15a1.7 1.7 0 0 0-1.6-1H6v-2.6h.2A1.7 1.7 0 0 0 8 10a1.7 1.7 0 0 0-.3-1.9l-.1-.1 1.8-1.8.1.1a1.7 1.7 0 0 0 1.9.3 1.7 1.7 0 0 0 1-1.6v-.2H15V5a1.7 1.7 0 0 0 1 1.6 1.7 1.7 0 0 0 1.9-.3l.1-.1 1.8 1.8-.1.1a1.7 1.7 0 0 0-.3 1.9 1.7 1.7 0 0 0 1.6 1h.2V14H21a1.7 1.7 0 0 0-1.6 1z"></path>
        `,
        user: `
            <circle cx="12" cy="8" r="4"></circle>
            <path d="M4 21a8 8 0 0 1 16 0"></path>
        `,
        dashboard: `
            <rect x="4" y="4" width="6" height="6" rx="1"></rect>
            <rect x="14" y="4" width="6" height="6" rx="1"></rect>
            <rect x="4" y="14" width="6" height="6" rx="1"></rect>
            <rect x="14" y="14" width="6" height="6" rx="1"></rect>
        `,
        home: `
            <path d="M3 11l9-8 9 8"></path>
            <path d="M5 10v10h14V10"></path>
            <path d="M9 20v-6h6v6"></path>
        `,
        learn: `
            <path d="M3 5.5A2.5 2.5 0 0 1 5.5 3H11v16H5.5A2.5 2.5 0 0 0 3 21z"></path>
            <path d="M21 5.5A2.5 2.5 0 0 0 18.5 3H13v16h5.5A2.5 2.5 0 0 1 21 21z"></path>
        `,
        course: `
            <path d="M4 4h16v16H4z"></path>
            <path d="M8 8h8"></path>
            <path d="M8 12h8"></path>
            <path d="M8 16h5"></path>
        `,
        certificate: `
            <circle cx="12" cy="9" r="5"></circle>
            <path d="M9 13l-1 8 4-2 4 2-1-8"></path>
        `,
        briefcase: `
            <rect x="3" y="7" width="18" height="13" rx="2"></rect>
            <path d="M8 7V5a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
            <path d="M3 12h18"></path>
        `,
        business: `
            <path d="M4 21V7l8-4 8 4v14"></path>
            <path d="M8 21v-5h8v5"></path>
            <path d="M8 10h1"></path>
            <path d="M15 10h1"></path>
        `,
        mail: `
            <rect x="3" y="5" width="18" height="14" rx="2"></rect>
            <path d="M3 7l9 6 9-6"></path>
        `,
        phone: `
            <path d="M6 3h3l2 5-2 2a14 14 0 0 0 5 5l2-2 5 2v3a2 2 0 0 1-2 2C11 20 4 13 4 5a2 2 0 0 1 2-2z"></path>
        `,
        info: `
            <circle cx="12" cy="12" r="9"></circle>
            <path d="M12 11v5"></path>
            <path d="M12 8h.01"></path>
        `,
        help: `
            <circle cx="12" cy="12" r="9"></circle>
            <path d="M9.5 9a2.5 2.5 0 1 1 4.1 1.9c-1.1.8-1.6 1.2-1.6 2.6"></path>
            <path d="M12 17h.01"></path>
        `,
        warning: `
            <path d="M12 3l9 16H3z"></path>
            <path d="M12 9v4"></path>
            <path d="M12 16h.01"></path>
        `,
        lock: `
            <rect x="5" y="10" width="14" height="11" rx="2"></rect>
            <path d="M8 10V7a4 4 0 0 1 8 0v3"></path>
        `,
        eye: `
            <path d="M2 12s4-6 10-6 10 6 10 6-4 6-10 6S2 12 2 12z"></path>
            <circle cx="12" cy="12" r="2.5"></circle>
        `,
        play: `
            <path d="M8 5l11 7-11 7z"></path>
        `,
        pause: `
            <path d="M8 5v14"></path>
            <path d="M16 5v14"></path>
        `,
        send: `
            <path d="M21 3L10 14"></path>
            <path d="M21 3l-7 18-4-7-7-4z"></path>
        `,
        heart: `
            <path d="M20.8 8.8c0 5.2-8.8 10.2-8.8 10.2S3.2 14 3.2 8.8A4.8 4.8 0 0 1 12 6a4.8 4.8 0 0 1 8.8 2.8z"></path>
        `,
        star: `
            <path d="M12 3l2.8 5.7 6.2.9-4.5 4.4 1.1 6.2-5.6-3-5.6 3 1.1-6.2L3 9.6l6.2-.9z"></path>
        `,
        link: `
            <path d="M10 13a5 5 0 0 0 7.1.1l2-2a5 5 0 0 0-7.1-7.1l-1.2 1.2"></path>
            <path d="M14 11a5 5 0 0 0-7.1-.1l-2 2a5 5 0 0 0 7.1 7.1l1.2-1.2"></path>
        `,
        external: `
            <path d="M14 4h6v6"></path>
            <path d="M20 4l-9 9"></path>
            <path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"></path>
        `,
        cart: `
            <path d="M3 4h2l2 11h10l3-8H6"></path>
            <circle cx="9" cy="19" r="1.5"></circle>
            <circle cx="17" cy="19" r="1.5"></circle>
        `,
        money: `
            <rect x="3" y="6" width="18" height="12" rx="2"></rect>
            <circle cx="12" cy="12" r="3"></circle>
            <path d="M7 9h.01"></path>
            <path d="M17 15h.01"></path>
        `,
        calendar: `
            <rect x="3" y="5" width="18" height="16" rx="2"></rect>
            <path d="M16 3v4"></path>
            <path d="M8 3v4"></path>
            <path d="M3 10h18"></path>
        `,
        clock: `
            <circle cx="12" cy="12" r="9"></circle>
            <path d="M12 7v5l3 2"></path>
        `,
        menu: `
            <path d="M4 7h16"></path>
            <path d="M4 12h16"></path>
            <path d="M4 17h16"></path>
        `,
        more: `
            <circle cx="5" cy="12" r="1"></circle>
            <circle cx="12" cy="12" r="1"></circle>
            <circle cx="19" cy="12" r="1"></circle>
        `
    };

    const RULES = [
        ["logout", ["logout", "sign out", "log out", "خروج"]],
        ["login", ["login", "log in", "sign in", "signin", "داخل", "لاگ ان", "سائن ان"]],
        ["register", ["register", "sign up", "create account", "create an account", "رجسٹر", "اکاؤنٹ بنائیں"]],
        ["save", ["save", "محفوظ"]],
        ["edit", ["edit", "update", "modify", "ترمیم", "اپ ڈیٹ"]],
        ["delete", ["delete", "remove", "trash", "حذف", "ڈیلیٹ", "ختم"]],
        ["search", ["search", "find", "تلاش"]],
        ["filter", ["filter", "فلٹر"]],
        ["add", ["add", "new", "create", "post", "اضافہ", "نیا", "بنائیں"]],
        ["close", ["close", "cancel", "dismiss", "بند", "منسوخ"]],
        ["back", ["back", "previous", "واپس", "پچھلا"]],
        ["next", ["next", "continue", "proceed", "آگے", "جاری رکھیں"]],
        ["check", ["submit", "done", "complete", "confirm", "ٹھیک", "مکمل", "جمع"]],
        ["verify", ["verify", "verification", "approve", "validate", "تصدیق"]],
        ["apply", ["apply", "application", "درخواست", "اپلائی"]],
        ["upload", ["upload", "attach", "import", "اپ لوڈ"]],
        ["download", ["download", "export", "ڈاؤن لوڈ"]],
        ["refresh", ["refresh", "reload", "retry", "تازہ", "دوبارہ"]],
        ["settings", ["settings", "preferences", "configuration", "ترتیبات"]],
        ["dashboard", ["dashboard", "ڈیش بورڈ"]],
        ["home", ["home", "ہوم"]],
        ["learn", ["learn", "learning", "study", "lesson", "course", "سیکھیں", "تعلیم"]],
        ["certificate", ["certificate", "certification", "سرٹیفکیٹ"]],
        ["briefcase", ["job", "jobs", "career", "work", "نوکری", "ملازمت"]],
        ["business", ["business", "company", "businesses", "کاروبار", "کمپنی"]],
        ["mail", ["email", "message", "messages", "mail", "ای میل", "پیغام"]],
        ["phone", ["call", "phone", "contact", "رابطہ"]],
        ["help", ["help", "support", "مدد"]],
        ["info", ["info", "information", "about", "معلومات"]],
        ["lock", ["password", "secure", "security", "privacy", "پاس ورڈ", "سیکیورٹی"]],
        ["eye", ["view", "preview", "show", "دیکھیں", "پیش نظارہ"]],
        ["play", ["play", "start", "شروع"]],
        ["pause", ["pause", "وقفہ"]],
        ["send", ["send", "submit request", "بھیجیں"]],
        ["heart", ["favorite", "favourite", "like", "پسندیدہ"]],
        ["star", ["featured", "star", "نمایاں"]],
        ["link", ["link", "connect", "integration", "لنک", "کنیکٹ"]],
        ["external", ["open", "visit", "external", "کھولیں"]],
        ["cart", ["buy", "purchase", "cart", "خرید"]],
        ["money", ["payment", "pay", "earn", "earning", "price", "ادائیگی", "کمائی"]],
        ["calendar", ["date", "schedule", "calendar", "تاریخ"]],
        ["clock", ["time", "duration", "وقت"]],
        ["menu", ["menu", "navigation", "مینو"]],
        ["more", ["more", "options", "مزید"]]
    ];

    function normalize(value) {
        return String(value || "")
            .replace(/\s+/g, " ")
            .trim()
            .toLowerCase();
    }

    function iconFor(element) {
        const explicit =
            element.getAttribute("data-icon") ||
            element.dataset.icon;

        if (explicit && ICONS[explicit]) {
            return explicit;
        }

        const aria = normalize(element.getAttribute("aria-label"));
        const title = normalize(element.getAttribute("title"));
        const text = normalize(element.textContent);

        const haystack = [aria, title, text].filter(Boolean).join(" ");

        for (const [icon, words] of RULES) {
            for (const word of words) {
                if (haystack.includes(normalize(word))) {
                    return icon;
                }
            }
        }

        return null;
    }

    function createIcon(name) {
        const svg = document.createElementNS(
            "http://www.w3.org/2000/svg",
            "svg"
        );

        svg.setAttribute("class", "leh-button-icon");
        svg.setAttribute("viewBox", "0 0 24 24");
        svg.setAttribute("width", "20");
        svg.setAttribute("height", "20");
        svg.setAttribute("aria-hidden", "true");
        svg.setAttribute("focusable", "false");
        svg.innerHTML = ICONS[name];

        return svg;
    }

    function isEligible(element) {
        if (!element || element.nodeType !== 1) {
            return false;
        }

        if (
            element.matches(
                "button, .btn, [role='button'], .card-link"
            )
        ) {
            return true;
        }

        return false;
    }

    function enhance(element) {
        if (!isEligible(element)) {
            return;
        }

        if (element.dataset.lehIconProcessed === "true") {
            return;
        }

        if (
            element.querySelector(
                ".leh-button-icon, svg, i, .icon, .material-icons, .fa, [data-icon]"
            )
        ) {
            element.dataset.lehIconProcessed = "true";
            return;
        }

        const name = iconFor(element);

        if (!name || !ICONS[name]) {
            element.dataset.lehIconProcessed = "true";
            return;
        }

        const icon = createIcon(name);

        if (element.classList.contains("card-link")) {
            element.prepend(icon);
        } else {
            element.prepend(icon);
        }

        element.classList.add("leh-icon-ready");
        element.dataset.lehIcon = name;
        element.dataset.lehIconProcessed = "true";
    }

    function scan(root) {
        if (!root) {
            return;
        }

        if (root.nodeType === 1) {
            enhance(root);
        }

        if (root.querySelectorAll) {
            root
                .querySelectorAll(
                    "button, .btn, [role='button'], .card-link"
                )
                .forEach(enhance);
        }
    }

    function init() {
        scan(document);

        const observer = new MutationObserver(function (mutations) {
            for (const mutation of mutations) {
                mutation.addedNodes.forEach(function (node) {
                    if (node.nodeType === 1) {
                        scan(node);
                    }
                });
            }
        });

        observer.observe(document.body, {
            childList: true,
            subtree: true
        });

        window.LearnEarnHubButtonIcons = {
            refresh: function () {
                document
                    .querySelectorAll(
                        "button, .btn, [role='button'], .card-link"
                    )
                    .forEach(function (element) {
                        element.dataset.lehIconProcessed = "";
                        enhance(element);
                    });
            }
        };
    }

    if (document.readyState === "loading") {
        document.addEventListener("DOMContentLoaded", init);
    } else {
        init();
    }
})();
