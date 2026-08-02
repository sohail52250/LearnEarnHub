#!/data/data/com.termux/files/usr/bin/bash

echo "=== Adding global important buttons ==="

python - <<'PY'
from pathlib import Path

nav='''
<div class="leh-global-nav">
<a href="/index.html">🏠 Home</a>
<a href="/learn.html">📚 Learn</a>
<a href="/jobs.html">💼 Jobs</a>
<a href="/task-marketplace.html">💰 Tasks</a>
<a href="/marketplace.html">🏪 Marketplace</a>
<a href="/post-job.html">📝 Post Job</a>
<a href="/login.html">🔐 Login</a>
<a href="/developer/login.html">🛠 Developer</a>
</div>
<style>
.leh-global-nav{
display:flex;
flex-wrap:wrap;
gap:8px;
padding:12px;
background:#f5f5f5;
border-radius:10px;
margin:10px 0;
}
.leh-global-nav a{
padding:8px 12px;
border-radius:8px;
text-decoration:none;
background:white;
border:1px solid #ddd;
font-size:14px;
}
</style>
'''

for p in Path("public").rglob("*.html"):
    try:
        s=p.read_text(errors="ignore")
        if "leh-global-nav" not in s and "<body" in s:
            s=s.replace("<body>", "<body>"+nav, 1)
            p.write_text(s)
            print("Updated:",p)
    except:
        pass

print("Navigation added")
PY

git add .
git commit -m "Add global important navigation buttons" || true
git push

vercel --prod

echo "=== Completed ==="
