require("dotenv").config();

const { createClient } = require("@supabase/supabase-js");

console.log("URL:", process.env.SUPABASE_URL);

const db = createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_KEY
);

module.exports = db;
