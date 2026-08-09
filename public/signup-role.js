/*
 * LearnEarnHub canonical registration bridge.
 *
 * Generic registration is handled by:
 *   /register-v2.html
 *   /register-v2.js
 *
 * Role metadata is submitted through Supabase Auth metadata there.
 */

(function () {
    "use strict";

    function goToCanonicalRegistration() {
        window.location.href = "/register-v2.html";
    }

    window.signupRole = goToCanonicalRegistration;
    window.registerUser = goToCanonicalRegistration;
})();
