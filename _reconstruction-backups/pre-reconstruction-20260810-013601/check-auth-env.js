require("dotenv").config();

console.log(
process.env.SUPABASE_URL
?
"✅ SUPABASE_URL found"
:
"❌ Missing SUPABASE_URL"
);

console.log(
process.env.SUPABASE_ANON_KEY
?
"✅ SUPABASE_ANON_KEY found"
:
"❌ Missing SUPABASE_ANON_KEY"
);

