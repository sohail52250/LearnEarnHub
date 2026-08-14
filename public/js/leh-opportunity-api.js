(function (window) {
    "use strict";

    async function request(url) {
        const response = await fetch(url, {
            method: "GET",
            headers: {
                "Accept": "application/json"
            },
            credentials: "same-origin"
        });

        let body = null;

        try {
            body = await response.json();
        } catch (_) {
            body = null;
        }

        if (!response.ok) {
            const message =
                body && (body.error || body.message)
                    ? (body.error || body.message)
                    : "Opportunity request failed.";

            const error = new Error(message);

            error.status = response.status;
            error.body = body;

            throw error;
        }

        return body;
    }

    async function getMatches(userId, limit) {
        const params = new URLSearchParams();

        if (userId) {
            params.set(
                "user_id",
                String(userId)
            );
        }

        if (limit) {
            params.set(
                "limit",
                String(limit)
            );
        }

        const query =
            params.toString();

        return request(
            "/api/opportunities/matches" +
            (query ? "?" + query : "")
        );
    }

    async function getOpportunity(reference) {

        if (!reference) {
            throw new Error(
                "Opportunity reference is required."
            );
        }

        return request(
            "/api/opportunities/" +
            encodeURIComponent(
                String(reference)
            )
        );
    }

    window.LearnEarnHubOpportunityAPI =
        Object.freeze({
            getMatches,
            getOpportunity
        });

})(window);