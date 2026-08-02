#!/data/data/com.termux/files/usr/bin/bash

echo "=== Adding Mobile Bottom Navigation ==="

python - <<'PY'
from pathlib import Path

nav=r'''
<div class="leh-bottom-nav">
<a href="/index.html">🏠<span>Home</span></a>
<a href="/learn.html">📚<span>Learn</span></a>
<a href="/jobs.html">💼<span>Jobs</span></a>
<a href="/task-marketplace.html">💰<span>Earn</span></a>
<a href="/learner-dashboard.html">👤<span>Dashboard</span></a>
</div>

<style>
.leh-bottom-nav{
display:none;
}

@media(max-width:700px){
.leh-bottom-nav{
position:fixed;
bottom:0;
left:0;
right:0;
display:flex;
justify-content:space-around;
background:white;
border-top:1px solid #ddd;
padding:8px 4px;
z-index:9999;
}

.leh-bottom-nav a{
text-align:center;
text-decoration:none;
font-size:12px;
}

.leh-bottom-nav span{
display:block;
}
body{
padding-bottom:70px;
}
}
</style>
'''

count=0

for p in Path("public").rglob("*.html"):
    try:
        s=p.read_text(errors="ignore")

        if "<body" in s and "leh-bottom-nav" not in s:
            s=s.replace("</body>",nav+"</body>",1)
            p.write_text(s)
            count+=1
            print("Updated:",p)

    except:
        pass

print("Total updated:",count)
PY

git add .
git commit -m "Add mobile bottom navigation" || true
git push

vercel --prod

echo "=== Completed ==="
