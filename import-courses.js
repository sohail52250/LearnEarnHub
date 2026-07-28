require("dotenv").config();

const { createClient } = require("@supabase/supabase-js");
const course = require("./course-content.json");

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_KEY
);

async function run() {

  const { data, error } = await supabase
    .from("courses")
    .insert([course])
    .select();

  console.log("DATA:", data);
  console.log("ERROR:", error);

}

run();
