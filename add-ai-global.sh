#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "=== LearnEarnHub Global AI Chat Installer ==="


HEADER="public/global-header.html"


echo "=== Checking files ==="

if [ ! -f "public/assets/css/leh-ai-chat.css" ]; then
echo "Missing AI CSS file"
exit 1
fi

if [ ! -f "public/assets/js/leh-ai-chat.js" ]; then
echo "Missing AI JS file"
exit 1
fi


echo "=== Adding AI CSS ==="

if ! grep -q "leh-ai-chat.css" "$HEADER"; then

sed -i 's#</head>#<link rel="stylesheet" href="/assets/css/leh-ai-chat.css">\n</head>#' "$HEADER"

fi


echo "=== Adding AI JS ==="

if ! grep -q "leh-ai-chat.js" "$HEADER"; then

sed -i 's#</header>#</header>\n<script src="/assets/js/leh-ai-chat.js"></script>#' "$HEADER"

fi


echo "=== Checking result ==="

grep -n "leh-ai-chat" "$HEADER" || true


echo "=== Git update ==="

git add .

git commit -m "Add global LearnEarnHub AI chat integration" || echo "No changes"

git push


echo "=== Deploying Vercel ==="

vercel --prod


echo "=== Completed Successfully ==="

