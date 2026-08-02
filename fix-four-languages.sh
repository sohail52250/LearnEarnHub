#!/data/data/com.termux/files/usr/bin/bash

echo "=== Updating Language System: English Urdu Arabic Dutch ==="

# Replace common language selector lists
find public -type f \( -name "*.html" -o -name "*.js" \) -print0 | xargs -0 sed -i \
-e 's/Spanish//g' \
-e 's/French//g' \
-e 's/German//g' \
-e 's/Chinese//g' \
-e 's/Hindi//g'

# Create language configuration
cat > public/language-config.js <<'JS'
window.LEH_LANGUAGES = [
 {
  code:"en",
  name:"English"
 },
 {
  code:"ur",
  name:"اردو"
 },
 {
  code:"ar",
  name:"العربية"
 },
 {
  code:"nl",
  name:"Nederlands"
 }
];
JS


# Ensure main pages load config
find public -name "*.html" -print0 | while IFS= read -r -d '' f
do
 if ! grep -q "language-config.js" "$f"; then
   sed -i 's#</head>#<script src="/language-config.js"></script>\n</head>#' "$f"
 fi
done


git add .
git commit -m "Set platform languages to English Urdu Arabic Dutch" || true
git push

vercel --prod

echo "=== Language update completed ==="
