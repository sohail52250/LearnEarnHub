(function (window, document) {
    "use strict";

    const api = window.LearnEarnHubOpportunityAPI;

    if (!api) {
        throw new Error(
            "LearnEarnHubOpportunityAPI is required before the opportunity UI."
        );
    }

    function escapeHtml(value) {
        return String(value == null ? "" : value)
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }

    function firstValue(object, keys, fallback) {
        for (const key of keys) {
            if (
                object &&
                object[key] !== undefined &&
                object[key] !== null &&
                String(object[key]).trim() !== ""
            ) {
                return object[key];
            }
        }

        return fallback;
    }

    function normalizeMatches(payload) {
        if (!payload) {
            return [];
        }

        if (Array.isArray(payload)) {
            return payload;
        }

        if (Array.isArray(payload.matches)) {
            return payload.matches;
        }

        if (Array.isArray(payload.data)) {
            return payload.data;
        }

        if (payload.data && Array.isArray(payload.data.matches)) {
            return payload.data.matches;
        }

        return [];
    }

    function getReference(item) {
        return firstValue(
            item,
            [
                "reference",
                "opportunity_reference",
                "opportunityReference",
                "slug",
                "id"
            ],
            ""
        );
    }

    function renderEmpty(container, message) {
        container.innerHTML =
            '<div class="leh-opportunity-empty">' +
            '<h2>No opportunities found</h2>' +
            '<p>' + escapeHtml(message) + '</p>' +
            '</div>';
    }

    function renderError(container, error) {
        container.innerHTML =
            '<div class="leh-opportunity-error">' +
            '<h2>Unable to load opportunities</h2>' +
            '<p>' +
            escapeHtml(
                error && error.message
                    ? error.message
                    : "Please try again later."
            ) +
            '</p>' +
            '</div>';
    }

    function renderMatches(container, matches) {
        if (!matches.length) {
            renderEmpty(
                container,
                "There are currently no matching opportunities."
            );
            return;
        }

        container.innerHTML = matches
            .map(function (item) {
                const title = firstValue(
                    item,
                    ["title", "name", "opportunity_title"],
                    "Opportunity"
                );

                const description = firstValue(
                    item,
                    ["description", "summary", "details"],
                    "View the opportunity details."
                );

                const category = firstValue(
                    item,
                    ["category", "type", "opportunity_type"],
                    "Opportunity"
                );

                const reference = getReference(item);

                const href = reference
                    ? "/opportunities.html?reference=" +
                      encodeURIComponent(String(reference))
                    : "#";

                return (
                    '<article class="leh-opportunity-card">' +
                    '<div class="leh-opportunity-card__category">' +
                    escapeHtml(category) +
                    '</div>' +
                    '<h2>' +
                    escapeHtml(title) +
                    '</h2>' +
                    '<p>' +
                    escapeHtml(description) +
                    '</p>' +
                    '<a class="leh-opportunity-card__action" href="' +
                    href +
                    '">' +
                    'View opportunity' +
                    '</a>' +
                    '</article>'
                );
            })
            .join("");
    }

    async function loadMatches() {
        const container = document.getElementById(
            "leh-opportunity-results"
        );

        if (!container) {
            return;
        }

        container.innerHTML =
            '<div class="leh-opportunity-loading">' +
            'Loading opportunities...' +
            '</div>';

        try {
            const userId =
                document.body.dataset.userId || "";

            const payload = await api.getMatches(
                userId || undefined,
                20
            );

            renderMatches(
                container,
                normalizeMatches(payload)
            );
        }
        catch (error) {
            renderError(container, error);
        }
    }

    async function loadDetail(reference) {
        const container = document.getElementById(
            "leh-opportunity-detail"
        );

        if (!container || !reference) {
            return;
        }

        container.innerHTML =
            '<div class="leh-opportunity-loading">' +
            'Loading opportunity...' +
            '</div>';

        try {
            const payload =
                await api.getOpportunity(reference);

            const item =
                payload &&
                payload.data
                    ? payload.data
                    : payload;

            if (!item) {
                renderEmpty(
                    container,
                    "This opportunity could not be found."
                );
                return;
            }

            const title = firstValue(
                item,
                ["title", "name", "opportunity_title"],
                "Opportunity"
            );

            const description = firstValue(
                item,
                ["description", "summary", "details"],
                "No description is available."
            );

            const category = firstValue(
                item,
                ["category", "type", "opportunity_type"],
                "Opportunity"
            );

            container.innerHTML =
                '<article class="leh-opportunity-detail-card">' +
                '<div class="leh-opportunity-card__category">' +
                escapeHtml(category) +
                '</div>' +
                '<h1>' +
                escapeHtml(title) +
                '</h1>' +
                '<p>' +
                escapeHtml(description) +
                '</p>' +
                '<a class="leh-opportunity-back" href="/opportunities.html">' +
                '← Back to opportunities' +
                '</a>' +
                '</article>';
        }
        catch (error) {
            renderError(container, error);
        }
    }

    function initialize() {
        const params =
            new URLSearchParams(window.location.search);

        const reference =
            params.get("reference");

        if (reference) {
            loadDetail(reference);
        }
        else {
            loadMatches();
        }
    }

    window.LearnEarnHubOpportunityUI =
        Object.freeze({
            loadMatches,
            loadDetail,
            initialize
        });

    if (
        document.readyState === "loading"
    ) {
        document.addEventListener(
            "DOMContentLoaded",
            initialize
        );
    }
    else {
        initialize();
    }

})(window, document);