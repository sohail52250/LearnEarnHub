(function (global) {
    "use strict";

    var KEY = "leh_oauth_return";
    var DEFAULT_TARGET = "/dashboard/";

    function validTarget(value) {
        return typeof value === "string" &&
            value.charAt(0) === "/" &&
            value.indexOf("//") !== 0 &&
            value.indexOf("javascript:") !== 0;
    }

    function getTarget() {
        try {
            var target =
                sessionStorage.getItem(KEY) ||
                localStorage.getItem(KEY);

            return validTarget(target) ? target : DEFAULT_TARGET;
        } catch (_) {
            return DEFAULT_TARGET;
        }
    }

    function clearTarget() {
        try {
            sessionStorage.removeItem(KEY);
            localStorage.removeItem(KEY);
        } catch (_) {}
    }

    async function getSession() {
        var clients = [
            global.supabaseClient,
            global.supabase
        ];

        for (var i = 0; i < clients.length; i++) {
            var client = clients[i];

            if (
                client &&
                client.auth &&
                typeof client.auth.getSession === "function"
            ) {
                try {
                    var result = await client.auth.getSession();

                    if (
                        result &&
                        result.data &&
                        result.data.session &&
                        result.data.session.user
                    ) {
                        return result.data.session;
                    }
                } catch (_) {}
            }
        }

        return null;
    }

    async function waitForSession() {
        for (var i = 0; i < 20; i++) {
            var session = await getSession();

            if (session) {
                return session;
            }

            await new Promise(function (resolve) {
                setTimeout(resolve, 500);
            });
        }

        return null;
    }

    async function handle() {
        var session = await waitForSession();

        if (!session) {
            return false;
        }

        var target = getTarget();

        clearTarget();

        if (
            global.location.pathname === "/auth/sign-in.html" ||
            global.location.pathname === "/dashboard-router.html"
        ) {
            global.location.replace(target);
            return true;
        }

        return true;
    }

    global.LEHOAuthSessionReturn = {
        getSession: getSession,
        waitForSession: waitForSession,
        handle: handle,
        getTarget: getTarget
    };

    if (global.document.readyState === "loading") {
        global.document.addEventListener("DOMContentLoaded", function () {
            handle();
        });
    } else {
        handle();
    }
})(window);
