/*
 * LearnEarnHub authentication flow guidance.
 *
 * This does NOT replace authentication forms.
 * It adds clear directions around the appropriate flow.
 */
(function () {
    "use strict";

    function path() {
        return String(window.location.pathname || "").toLowerCase();
    }

    function createBox(title, text, links) {
        const box = document.createElement("section");

        box.className = "leh-auth-flow-guidance";
        box.setAttribute("data-leh-auth-guidance", "true");

        box.innerHTML =
            '<div class="leh-auth-flow-guidance-inner">' +
            "<h2>" + title + "</h2>" +
            "<p>" + text + "</p>" +
            '<div class="leh-auth-flow-guidance-links">' +
            links.map(function (link) {
                return (
                    '<a class="btn btn-primary" href="' +
                    link.href +
                    '">' +
                    link.label +
                    "</a>"
                );
            }).join("") +
            "</div>" +
            "</div>";

        return box;
    }

    function addGuidance() {
        if (document.querySelector("[data-leh-auth-guidance='true']")) {
            return;
        }

        const current = path();

        let config = null;

        if (
            current.endsWith("/auth/sign-in.html") ||
            current.endsWith("/login-v2.html")
        ) {
            config = {
                title: "Sign in to LearnEarnHub",
                text:
                    "Already have a LearnEarnHub account? Sign in below. " +
                    "New to LearnEarnHub? Create a free account first.",
                links: [
                    {
                        label: "Create an account",
                        href: "/register.html"
                    }
                ]
            };
        } else if (
            current.endsWith("/register.html") ||
            current.endsWith("/register-v2.html")
        ) {
            config = {
                title: "Create your LearnEarnHub account",
                text:
                    "New to LearnEarnHub? Register your account below. " +
                    "Already registered? Sign in instead.",
                links: [
                    {
                        label: "Already registered? Sign in",
                        href: "/auth/sign-in.html"
                    }
                ]
            };
        } else if (current.endsWith("/admin-login.html")) {
            config = {
                title: "Administrator sign in",
                text:
                    "This page is for authorized LearnEarnHub administrators. " +
                    "Use your administrator credentials to continue.",
                links: [
                    {
                        label: "Back to LearnEarnHub",
                        href: "/index.html"
                    }
                ]
            };
        } else if (current.endsWith("/developer/auth/sign-in.html")) {
            config = {
                title: "Developer sign in",
                text:
                    "This page is for LearnEarnHub developer accounts. " +
                    "Sign in to access developer tools and your developer dashboard.",
                links: [
                    {
                        label: "Back to LearnEarnHub",
                        href: "/index.html"
                    }
                ]
            };
        } else if (current.endsWith("/business-register.html")) {
            config = {
                title: "Business account",
                text:
                    "Are you a business? Register your business account to access " +
                    "business tools. Already registered? Sign in with your business account.",
                links: [
                    {
                        label: "Learn more about business",
                        href: "/business-guide.html"
                    },
                    {
                        label: "Business area",
                        href: "/business.html"
                    }
                ]
            };
        } else if (
            current.endsWith("/signup-role.html") ||
            current.endsWith("/signup-v2.html")
        ) {
            config = {
                title: "Choose your LearnEarnHub path",
                text:
                    "Choose the role that matches what you want to do: " +
                    "learn, teach, work, or operate a business. " +
                    "You can sign in if you already have an account.",
                links: [
                    {
                        label: "Already have an account? Sign in",
                        href: "/auth/sign-in.html"
                    },
                    {
                        label: "Explore learning",
                        href: "/learn.html"
                    }
                ]
            };
        }

        if (!config) {
            return;
        }

        const target =
            document.querySelector("main") ||
            document.querySelector(".container") ||
            document.querySelector("body");

        if (!target) {
            return;
        }

        target.insertBefore(
            createBox(
                config.title,
                config.text,
                config.links
            ),
            target.firstChild
        );
    }

    if (document.readyState === "loading") {
        document.addEventListener("DOMContentLoaded", addGuidance);
    } else {
        addGuidance();
    }
})();
