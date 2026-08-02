#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Auth Auto Setup ==="

read -p "Enter Supabase URL: " SUPABASE_URL

read -p "Enter Supabase ANON KEY: " SUPABASE_ANON_KEY


if [ -z "$SUPABASE_URL" ] || [ -z "$SUPABASE_ANON_KEY" ]
then
echo "❌ Keys missing"
exit 1
fi


mkdir -p public


cat > public/auth-config.js <<JS
window.SUPABASE_URL="$SUPABASE_URL";
window.SUPABASE_ANON_KEY="$SUPABASE_ANON_KEY";
JS



python - <<'PY'
from pathlib import Path

p=Path("public/auth.html")

if p.exists():

    s=p.read_text()

    s=s.replace(
    "YOUR_SUPABASE_URL",
    "${SUPABASE_URL}"
    )

    s=s.replace(
    "YOUR_ANON_KEY",
    "${SUPABASE_ANON_KEY}"
    )

    p.write_text(s)

PY


cat >> .env <<EOF

# Supabase Auth
SUPABASE_ANON_KEY=$SUPABASE_ANON_KEY
