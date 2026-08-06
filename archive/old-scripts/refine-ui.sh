#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "=== LearnEarnHub UI Refinement Started ==="

mkdir -p public/assets/css

CSS="public/assets/css/learn-earnhub-ui.css"

cat > "$CSS" <<'CSS'
/* LearnEarnHub Professional UI Layer */

:root {
  --leh-primary:#2563eb;
  --leh-secondary:#16a34a;
  --leh-dark:#0f172a;
  --leh-light:#f8fafc;
  --leh-card:#ffffff;
  --leh-border:#e2e8f0;
  --leh-shadow:0 10px 30px rgba(15,23,42,.08);
  --leh-radius:16px;
}

* {
  box-sizing:border-box;
}

body {
  background:var(--leh-light);
  color:#1e293b;
  font-family:
  Inter,
  system-ui,
  -apple-system,
  "Segoe UI",
  sans-serif;
  line-height:1.6;
}

img {
  max-width:100%;
  height:auto;
}

.container,
main,
section {
  max-width:1200px;
  margin:auto;
}

.card,
.course-card,
.dashboard-card,
.feature-card,
.market-card {
  background:var(--leh-card);
  border:1px solid var(--leh-border);
  border-radius:var(--leh-radius);
  box-shadow:var(--leh-shadow);
  padding:20px;
  transition:.25s ease;
}

.card:hover,
.course-card:hover,
.dashboard-card:hover {
  transform:translateY(-4px);
}

button,
.btn,
a.button {
  background:var(--leh-primary);
  color:white!important;
  border:none;
  border-radius:12px;
  padding:12px 22px;
  cursor:pointer;
  font-weight:600;
  text-decoration:none;
  display:inline-block;
}

button:hover,
.btn:hover,
a.button:hover {
  opacity:.9;
}

input,
textarea,
select {
  border:1px solid var(--leh-border);
  border-radius:12px;
  padding:12px;
  width:100%;
}

h1,h2,h3 {
  color:var(--leh-dark);
  font-weight:700;
}

.navbar,
header {
  backdrop-filter:blur(10px);
  position:sticky;
  top:0;
  z-index:1000;
}

footer {
  margin-top:40px;
  padding:30px;
  background:var(--leh-dark);
  color:white;
}

.grid {
  display:grid;
  gap:20px;
  grid-template-columns:repeat(auto-fit,minmax(260px,1fr));
}

.badge {
  background:#dcfce7;
  color:#166534;
  padding:5px 12px;
  border-radius:20px;
}

@media(max-width:768px){

  body {
    font-size:15px;
  }

  h1 {
    font-size:28px;
  }

  .card,
  .course-card {
    padding:15px;
  }

  .grid {
    grid-template-columns:1fr;
  }

}
CSS


echo "=== Injecting CSS links ==="

find public -type f -name "*.html" \
! -path "*/node_modules/*" \
! -path "*/backups/*" \
! -path "*/.git/*" \
| while read file
do

if ! grep -q "learn-earnhub-ui.css" "$file"; then

python3 - "$file" <<'PY'
import sys

f=sys.argv[1]

with open(f,"r",encoding="utf-8",errors="ignore") as x:
    data=x.read()

link='<link rel="stylesheet" href="/assets/css/learn-earnhub-ui.css">'

if "</head>" in data:
    data=data.replace("</head>",link+"\n</head>",1)

    with open(f,"w",encoding="utf-8") as x:
        x.write(data)
PY

echo "Updated: $file"

fi

done


echo "=== Checking ==="

grep -R "learn-earnhub-ui.css" public --include="*.html" | wc -l

echo "=== UI Refinement Completed ==="

echo "Next:"
echo "git add ."
echo "git commit -m 'Add professional UI framework'"
echo "git push"
echo "vercel --prod"

