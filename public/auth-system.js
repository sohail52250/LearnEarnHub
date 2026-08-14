
async function signUpUser(email,password){

const client =
supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data,error}=await client.auth.signUp({

email:email,

password:password

});


if(error){

alert(error.message);

return;

}


alert("Account created. Check email verification.");

return data;

}



async function loginUser(email,password){

const client =
supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data,error}=await client.auth.signInWithPassword({

email:email,

password:password

});


if(error){

alert(error.message);

return;

}


localStorage.setItem(
"user",
JSON.stringify(data.user)
);


window.location.href="/dashboard-router.html";


}



async function logoutUser(){

const client =
supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


await client.auth.signOut();


localStorage.removeItem("user");


window.location.href="/index.html";

}



async function resetPassword(email){

const client =
supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {error}=await client.auth.resetPasswordForEmail(email);


if(error){

alert(error.message);

return;

}


alert("Password reset email sent.");

}



window.signUpUser=signUpUser;

window.loginUser=loginUser;

window.logoutUser=logoutUser;

window.resetPassword=resetPassword;

/* LEH_GLOBAL_AUTH_NAV_V2 */
(function () {
    "use strict";

    function getStoredSession() {
        try {
            return {
                accessToken: localStorage.getItem("access_token"),
                refreshToken: localStorage.getItem("refresh_token"),
                userId: localStorage.getItem("user_id"),
                user: localStorage.getItem("user")
            };
        } catch (e) {
            return {};
        }
    }

    function isLoggedIn() {
        const session = getStoredSession();

        return !!(
            session.accessToken ||
            session.userId ||
            session.user
        );
    }

    function currentPath() {
        return String(window.location.pathname || "").toLowerCase();
    }

    function isAuthenticationPage() {
        const path = currentPath();

        return (
            path.endsWith("/auth/sign-in.html") ||
            path.endsWith("/login-v2.html") ||
            path.endsWith("/register.html") ||
            path.endsWith("/register-v2.html") ||
            path.endsWith("/signup-role.html") ||
            path.endsWith("/signup-v2.html") ||
            path.endsWith("/admin-login.html") ||
            path.endsWith("/developer/auth/sign-in.html") ||
            path.endsWith("/business-register.html")
        );
    }

    function setVisibility(element, visible) {
        if (!element) return;

        element.style.display = visible ? "" : "none";
        element.setAttribute(
            "aria-hidden",
            visible ? "false" : "true"
        );
    }

    function applySelectors(selectors, visible) {
        selectors.forEach(function (selector) {
            document.querySelectorAll(selector).forEach(function (element) {
                setVisibility(element, visible);
            });
        });
    }

    function updateNavigation() {
        const loggedIn = isLoggedIn();

        /*
         * These selectors target navigation controls.
         * Authentication forms themselves are NOT removed.
         */
        const loginNavigation = [
            "#login-link",
            "#login-btn",
            ".login-link",
            ".login-btn",
            ".nav-login",
            ".auth-login-link",
            "[data-auth='login']",
            "[data-auth-action='login']"
        ];

        const registerNavigation = [
            "#register-link",
            "#register-btn",
            ".register-link",
            ".register-btn",
            ".nav-register",
            ".auth-register-link",
            "[data-auth='register']",
            "[data-auth-action='register']"
        ];

        const logoutNavigation = [
            "#logout",
            "#logout-link",
            "#logout-btn",
            ".logout-link",
            ".logout-btn",
            ".nav-logout",
            ".auth-logout-link",
            "[data-auth='logout']",
            "[data-auth-action='logout']"
        ];

        /*
         * URL-based navigation links are handled separately.
         * We only target <a> elements here so login/register forms
         * and submit buttons remain available on their own pages.
         */
        const loginLinks = [
            "a[href$='/auth/sign-in.html']",
            "a[href$='login.html']",
            "a[href$='/login-v2.html']",
            "a[href$='login-v2.html']"
        ];

        const registerLinks = [
            "a[href$='/register.html']",
            "a[href$='register.html']",
            "a[href$='/register-v2.html']",
            "a[href$='register-v2.html']",
            "a[href$='/signup-role.html']",
            "a[href$='signup-role.html']",
            "a[href$='/signup-v2.html']",
            "a[href$='signup-v2.html']"
        ];

        /*
         * Authenticated:
         * Login/Register navigation hidden.
         * Logout shown.
         *
         * Logged out:
         * Login/Register navigation shown.
         * Logout hidden.
         */
        applySelectors(loginNavigation, !loggedIn);
        applySelectors(registerNavigation, !loggedIn);
        applySelectors(logoutNavigation, loggedIn);

        if (!loggedIn) {
            applySelectors(loginLinks, true);
            applySelectors(registerLinks, true);
        } else {
            applySelectors(loginLinks, false);
            applySelectors(registerLinks, false);
        }

        document.querySelectorAll("[data-auth-state]").forEach(function (element) {
            element.setAttribute(
                "data-authenticated",
                loggedIn ? "true" : "false"
            );
        });

        window.LEH_AUTHENTICATED = loggedIn;
    }

    function installLogoutHandlers() {
        document.querySelectorAll(
            "#logout, #logout-link, #logout-btn, " +
            ".logout-link, .logout-btn, .nav-logout, " +
            ".auth-logout-link, [data-auth='logout'], " +
            "[data-auth-action='logout']"
        ).forEach(function (element) {

            if (element.dataset.lehLogoutBound === "1") {
                return;
            }

            element.dataset.lehLogoutBound = "1";

            element.addEventListener("click", async function (event) {
                event.preventDefault();

                try {
                    if (typeof window.logoutUser === "function") {
                        await window.logoutUser();
                    } else if (
                        window.supabaseClient &&
                        window.supabaseClient.auth &&
                        typeof window.supabaseClient.auth.signOut === "function"
                    ) {
                        await window.supabaseClient.auth.signOut();
                    }
                } catch (error) {
                    console.warn("LearnEarnHub logout error:", error);
                }

                try {
                    [
                        "user",
                        "user_id",
                        "user_role",
                        "role",
                        "access_token",
                        "refresh_token"
                    ].forEach(function (key) {
                        localStorage.removeItem(key);
                    });
                } catch (error) {}

                window.dispatchEvent(new Event("leh-auth-changed"));
                window.location.href = "/index.html";
            });
        });
    }

    function refresh() {
        updateNavigation();
        installLogoutHandlers();
    }

    window.LEHUpdateAuthNavigation = refresh;

    if (document.readyState === "loading") {
        document.addEventListener("DOMContentLoaded", refresh);
    } else {
        refresh();
    }

    window.addEventListener("storage", refresh);
    window.addEventListener("leh-auth-changed", refresh);

})();
