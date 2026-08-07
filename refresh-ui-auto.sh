#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "=== LearnEarnHub UX/UI Refresh Started ==="

# Backup
echo "Creating backup..."
tar -czf "backup-before-ui-refresh-$(date +%Y%m%d-%H%M).tar.gz" public

# Create UI stylesheet
echo "Creating new UI system..."

mkdir -p public/assets/css

cat > public/assets/css/leh-final-ui.css <<'CSS'
:root {
 --leh-primary:#2563eb;
 --leh-secondary:#7c3aed;
 --leh-success:#10b981;
 --leh-bg:#f8fafc;
 --leh-card:#ffffff;
 --leh-text:#0f172a;
 --leh-muted:#64748b;
 --leh-radius:16px;
}

* {
 box-sizing:border-box;
}

html {
 scroll-behavior:smooth;
}

body {
 margin:0;
 background:var(--leh-bg);
 color:var(--leh-text);
 font-family:system-ui,-apple-system,Segoe UI,sans-serif;
 overflow-x:hidden;
}

main,
.container,
.wrapper,
.page-container {
 width:min(1200px,94%);
 margin-left:auto;
 margin-right:auto;
}

button,
.btn,
.button,
input[type="submit"] {
 background:var(--leh-primary);
 color:white;
 border:none;
 border-radius:var(--leh-radius);
 padding:12px 22px;
 cursor:pointer;
 transition:.2s;
}

button:hover,
.btn:hover,
.button:hover {
 transform:translateY(-1px);
}

.card,
.panel,
.box,
.content-card {
 background:var(--leh-card);
 border-radius:var(--leh-radius);
 padding:20px;
}

img {
 max-width:100%;
 height:auto;
}

input,
textarea,
select {
 max-width:100%;
 border-radius:12px;
 padding:12px;
}

@media(max-width:768px){

 .container,
 .wrapper,
 .page-container {
  width:96%;
 }

 button,
 .btn,
 .button {
  max-width:100%;
 }

 .grid,
 .row {
  display:block;
 }
}
CSS


# Add stylesheet to HTML pages
echo "Applying UI layer..."

python - <<'PY'
from pathlib import Path

tag='<link rel="stylesheet" href="/assets/css/leh-final-ui.css">'

count=0

for f in Path("public").rglob("*.html"):
    try:
        t=f.read_text(errors="ignore")
        if "</head>" in t and "leh-final-ui.css" not in t:
            t=t.replace("</head>", tag+"\n</head>",1)
            f.write_text(t)
            count+=1
    except:
        pass

print("Updated pages:",count)
PY


# Git deploy
echo "Deploying..."

git add .
git commit -m "Automated complete UX UI refresh" || true
git push origin main || true

vercel --prod

echo "=== UX/UI Refresh Complete ==="
