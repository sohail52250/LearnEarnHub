const service = require("../services/customer-need-service");

module.exports = async function (req, res) {
  try {
    if (req.method !== "POST") {
      return res.status(405).json({ success: false, error: "Method not allowed." });
    }

    const body = req.body || {};

    if (String(body.website || "").trim()) {
      return res.status(400).json({ success: false, error: "Invalid submission." });
    }

    const personType = String(body.person_type || "").trim();
    const requestType = String(body.request_type || "").trim();
    const title = String(body.title || "").trim();
    const problem = String(body.problem_description || "").trim();

    const allowedPersonTypes = ["customer", "student", "business", "supplier", "freelancer", "employer", "other"];
    const allowedRequestTypes = ["problem", "service-request", "product-request", "website-improvement", "learning-suggestion", "business-opportunity", "feature-request", "other"];
    const allowedUrgency = ["low", "normal", "high", "urgent"];

    if (!allowedPersonTypes.includes(personType)) {
      return res.status(400).json({ success: false, error: "Please select who you are." });
    }
    if (!allowedRequestTypes.includes(requestType)) {
      return res.status(400).json({ success: false, error: "Please select what you want to tell us." });
    }
    if (title.length < 3 || title.length > 160) {
      return res.status(400).json({ success: false, error: "Please provide a short title for your need." });
    }
    if (problem.length < 10 || problem.length > 5000) {
      return res.status(400).json({ success: false, error: "Please describe the problem or need in at least 10 characters." });
    }
    if (body.urgency && !allowedUrgency.includes(String(body.urgency))) {
      return res.status(400).json({ success: false, error: "Invalid urgency." });
    }

    const result = await service.createCustomerNeed({ ...body, person_type: personType, request_type: requestType, title, problem_description: problem });

    return res.status(201).json({
      success: true,
      message: "Thank you. Your need has been received for review.",
      reference_id: result.reference_id,
      status: result.status
    });
  } catch (error) {
    console.error("CUSTOMER NEED API ERROR:", error);
    return res.status(500).json({ success: false, error: "We could not receive your request right now. Please try again." });
  }
};
