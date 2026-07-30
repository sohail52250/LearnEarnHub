const express = require("express");
const router = express.Router();
const db = require("../database");

router.post("/", async (req, res) => {
  try {
    const { user_id, completed_course_id } = req.body;

    if (!user_id || !completed_course_id) {
      return res.json({
        success: false,
        error: "missing data"
      });
    }

    const current = await db
      .from("learning_path_courses")
      .select("sequence_number")
      .eq("course_id", completed_course_id)
      .single();

    if (!current.data) {
      return res.json({
        success: false,
        error: "Course not found"
      });
    }

    const next = await db
      .from("learning_path_courses")
      .select("*")
      .gt("sequence_number", current.data.sequence_number)
      .order("sequence_number")
      .limit(1)
      .single();

    if (!next.data) {
      return res.json({
        success: true,
        message: "Learning path completed"
      });
    }

    const { error } = await db
      .from("course_unlocks")
      .insert({
        user_id,
        course_id: next.data.course_id,
        unlocked: true,
        unlocked_at: new Date()
      });

    if (error) {
      return res.json({
        success: false,
        error: error.message
      });
    }

    res.json({
      success: true,
      message: "Next course unlocked",
      course_id: next.data.course_id
    });

  } catch (e) {
    res.status(500).json({
      success:false,
      error:e.message
    });
  }
});

module.exports = router;
