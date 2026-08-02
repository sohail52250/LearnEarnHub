#!/data/data/com.termux/files/usr/bin/bash

BIN="$HOME/bin"
mkdir -p "$BIN"

cat > "$BIN/leh-status" <<'CMD'
#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Status ==="

echo ""
echo "Project:"
pwd

echo ""
echo "Git:"
git status --short

echo ""
echo "Latest commit:"
git log -1 --oneline

echo ""
echo "Vercel:"
vercel ls | head -5

echo ""
echo "Website:"
curl -s https://learn-earnhub.vercel.app/api/developer/key-control

echo ""
CMD


cat > "$BIN/leh-deploy" <<'CMD'
#!/data/data/com.termux/files/usr/bin/bash

cd ~/EarnTask/LearnEarnHub

echo "=== Deploying LearnEarnHub ==="

git add .
git commit -m "Auto update deployment" 2>/dev/null || true
git push

vercel --prod
CMD


cat > "$BIN/leh-test-api" <<'CMD'
#!/data/data/com.termux/files/usr/bin/bash

echo "=== Testing LearnEarnHub APIs ==="

echo ""
echo "Developer keys:"
curl -s https://learn-earnhub.vercel.app/api/developer/key-control

echo ""

echo "Secure dashboard:"
curl -s https://learn-earnhub.vercel.app/api/developer/secure-dashboard

echo ""
CMD


chmod +x "$BIN/leh-status"
chmod +x "$BIN/leh-deploy"
chmod +x "$BIN/leh-test-api"


if ! grep -q "$HOME/bin" ~/.bashrc; then
 echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
fi

echo "Commands installed:"
echo "leh-status"
echo "leh-deploy"
echo "leh-test-api"

