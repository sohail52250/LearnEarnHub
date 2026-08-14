const service = require("../services/business-service");

module.exports = async function(req, res) {
    try {
        if (req.method === "GET") {

            const opportunityView =
                String(
                    req.query?.view ||
                    req.query?.action ||
                    ""
                )
                .trim()
                .toLowerCase();

            if (
                opportunityView === "opportunities" ||
                opportunityView === "open-opportunities"
            ) {

                const limit = Number(
                    req.query?.limit || 100
                );

                const opportunities =
                    await service.listOpportunities({
                        limit
                    });

                return res.status(200).json({
                    success: true,
                    opportunities,
                    count: opportunities.length
                });
            }

            const reference = String(
                req.query?.reference || ""
            ).trim();

            if (!reference) {
                return res.status(400).json({
                    success: false,
                    error: "Business reference is required."
                });
            }

            const business =
                await service.getBusiness(reference);

            if (!business) {
                return res.status(404).json({
                    success: false,
                    error: "Business not found."
                });
            }

            return res.status(200).json({
                success: true,
                business
            });
        }

        if (req.method !== "POST") {
            return res.status(405).json({
                success: false,
                error: "Method not allowed."
            });
        }

        const body = req.body || {};
        const action = String(body.action || "register").trim();

        if (action === "register") {
            if (!String(body.business_name || "").trim()) {
                return res.status(400).json({
                    success: false,
                    error: "Business name is required."
                });
            }

            const business = await service.createBusiness(body);

            return res.status(201).json({
                success: true,
                message: "Business registered successfully.",
                business
            });
        }

        if (action === "create-task") {
            const reference = String(
                body.business_reference || ""
            ).trim();

            if (!reference) {
                return res.status(400).json({
                    success: false,
                    error: "Business reference is required."
                });
            }

            if (!String(body.task_description || "").trim()) {
                return res.status(400).json({
                    success: false,
                    error: "Task description is required."
                });
            }

            const task = await service.createTask(reference, body);

            return res.status(201).json({
                success: true,
                message: "Business opportunity created.",
                task
            });
        }

        return res.status(400).json({
            success: false,
            error: "Invalid business action."
        });

    } catch (error) {
        console.error("BUSINESS API ERROR:", error);

        return res.status(500).json({
            success: false,
            error: error?.message || "Business operation failed."
        });
    }
};
