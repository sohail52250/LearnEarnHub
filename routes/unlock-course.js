const express = require("express");
const router = express.Router();
const db = require("../database");

router.post("/", async (req, res) => {
  try {
    const { user_id, completed_course_id } = req.body;

    if (!user_id || !completed_course_id) {
      return res.json({
        success:false,
        error:"missing data"
      });
    }

    const { data: current, error: currentError } = await db
      .from("learning_path_courses")
      .select("sequence_number")
      .eq("course_id", completed_course_id)
      .order("sequence_number")
      .limit(1)
      .maybeSingle();

    if (currentError) {
      return res.status(200).json({
        success:false,
        step:"current_course_lookup",
        error:currentError.message
      });
    }

    if (!current) {
      return res.json({
        success:false,
        error:"Course not found"
      });
    }

    const { data: next, error: nextError } = await db
      .from("learning_path_courses")
      .select("*")
      .gt("sequence_number", current.sequence_number)
      .order("sequence_number")
      .limit(1)
      .maybeSingle();

    if (nextError) {
      return res.json({
        success:false,
        step:"next_course_lookup",
        error:nextError.message
      });
    }

    if (!next) {
      return res.json({
        success:true,
        message:"Learning path completed"
      });
    }

    const { error: unlockError } = await db
      .from("course_unlocks")
      .insert({
        user_id:user_id,
        course_id:next.course_id,
        unlocked:true,
        unlocked_at:new Date()
      });

    if (unlockError) {
      return res.json({
        success:false,
        step:"unlock_insert",
        error:unlockError.message
      });
    }

    res.json({
      success:true,
      message:"Next course unlocked",
      course_id:next.course_id
    });

  } catch(e) {
    console.error(e);
    res.status(500).json({
      success:false,
      error:e.message
    });
  }
});

module.exports = router;
