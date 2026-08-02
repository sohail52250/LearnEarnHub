const { createClient } = require("@supabase/supabase-js");
require("dotenv").config();

const db = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_KEY
);

module.exports = async (req, res) => {
  const { data, error } = await db
    .from("developer_keys")
    .select("*");

  res.json({
    url: process.env.SUPABASE_URL,
    count: data ? data.length : 0,
    data,
    error
  });
};
