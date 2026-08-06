#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Supabase Keys Setup ==="

read -p "Enter SUPABASE_URL: " SUPABASE_URL

read -p "Enter SUPABASE_ANON_KEY: " SUPABASE_ANON_KEY


if [ -z "$SUPABASE_URL" ] || [ -z "$SUPABASE_ANON_KEY" ]; then
 echo "❌ Keys cannot be empty"
 exit 1
fi


touch .env


grep -q "SUPABASE_URL=" .env || echo "SUPABASE_URL=$SUPABASE_URL" >> .env
grep -q "SUPABASE_ANON_KEY=" .env || echo "SUPABASE_ANON_KEY=$SUPABASE_ANON_KEY" >> .env


mkdir -p public/js


cat > public/js/supabase-config.js <<JS
window.SUPABASE_URL="$SUPABASE_URL";
window.SUPABASE_ANON_KEY="$SUPABASE_ANON_KEY";

window.supabaseClient = supabase.createClient(
 window.SUPABASE_URL,
 window.SUPABASE_ANON_KEY
);
JS


echo "✅ Keys saved"
echo "✅ Frontend Supabase config created"

