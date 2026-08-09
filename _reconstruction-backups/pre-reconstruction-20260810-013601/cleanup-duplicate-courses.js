require("dotenv").config();
const { createClient } = require("@supabase/supabase-js");

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_KEY
);

async function cleanup() {

  console.log("Checking courses...");

  const { data: courses, error } = await supabase
    .from("courses")
    .select("*")
    .order("created_at", { ascending: true });

  if (error) {
    console.log("Fetch error:", error);
    return;
  }

  console.log("Total courses:", courses.length);

  const seen = new Map();
  const deleteIds = [];

  for (const course of courses) {

    const key = (course.title_en || course.title || "")
      .trim()
      .toLowerCase();

    if (!key) continue;

    if (seen.has(key)) {
      console.log(
        "Duplicate found:",
        course.id,
        "|",
        course.title_en
      );

      deleteIds.push(course.id);

    } else {
      seen.set(key, course.id);
    }
  }

  if (deleteIds.length === 0) {
    console.log("No duplicates found.");
    return;
  }

  console.log("\nDeleting IDs:", deleteIds);

  const { error: deleteError } = await supabase
    .from("courses")
    .delete()
    .in("id", deleteIds);

  if (deleteError) {
    console.log("Delete error:", deleteError);
    return;
  }

  console.log(
    "Deleted duplicate courses:",
    deleteIds.length
  );

  console.log("Cleanup completed.");
}

cleanup();
