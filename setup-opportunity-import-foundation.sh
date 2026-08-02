#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Opportunity Import Foundation ==="

mkdir -p scripts

cat > scripts/import-opportunities.js <<'JS'
require("dotenv").config();

const { createClient } = require("@supabase/supabase-js");

const db = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_KEY
);

async function seed() {

  const opportunities = [
    {
      title: "Remote Virtual Assistant",
      source: "LearnEarnHub Internal",
      description: "Sample imported opportunity",
      location: "Remote",
      opportunity_type: "Remote Work"
    },
    {
      title: "Freelance Content Writer",
      source: "LearnEarnHub Internal",
      description: "Sample imported opportunity",
      location: "Remote",
      opportunity_type: "Freelance"
    }
  ];

  const { error } = await db
    .from("external_opportunities")
    .insert(opportunities);

  if (error) {
    console.error(error);
    process.exit(1);
  }

  console.log("Imported:", opportunities.length);
}

seed();
JS

echo ""
echo "Foundation created:"
echo "scripts/import-opportunities.js"

