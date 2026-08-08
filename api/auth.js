const service = require("../services/auth-service");

module.exports = async function(req, res) {
    try {
        if (req.method !== "POST") {
            return res.status(405).json({
                success: false,
                error: "Method not allowed"
            });
        }

        const body = req.body || {};
        const action = String(body.action || "").trim();
        const email = String(body.email || "").trim();
        const password = String(body.password || "");
          const name = String(body.name || "").trim();

        if (!email || !password) {
            return res.status(400).json({
                success: false,
                error: "Email and password are required."
            });
        }

        if (action === "signup") {
            const user = await service.signup(email, password, name);

            return res.status(200).json({
                success: true,
                message: "Account created successfully.",
                user: user || null
            });
        }

        if (action === "login") {
            const data = await service.login(email, password);

            return res.status(200).json({
                success: true,
                message: "Login successful.",
                user: data?.user || null,
                session: data?.session || null
            });
        }

        return res.status(400).json({
            success: false,
            error: "Invalid authentication action."
        });

    } catch (error) {
        console.error("AUTH API ERROR:", error);

        return res.status(500).json({
            success: false,
            error: error?.message || "Authentication failed."
        });
    }
};
