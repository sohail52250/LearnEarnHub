const express = require("express");
const router = express.Router();

const {
  checkAndCreateCertificate
} = require("../services/certificate-service");

router.get("/:user_id/:course_id", async (req, res) => {
  try {
    const result = await checkAndCreateCertificate(
      req.params.user_id,
      req.params.course_id
    );

    res.json(result);
  } catch (error) {
    console.error("Certificate route error:", error);
    res.status(500).json({
      success: false,
      error: "Certificate processing failed"
    });
  }
});

module.exports = router;
