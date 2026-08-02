#!/data/data/com.termux/files/usr/bin/bash

echo "=== Connecting External Jobs Feed ==="

python - <<'PY'
from pathlib import Path

p=Path("public/jobs.js")

if not p.exists():
    p.write_text("""
async function loadJobs(){
 const r=await fetch('/api/external/jobs-feed');
 const data=await r.json();

 const box=document.getElementById('jobs');

 if(!data.jobs) return;

 box.innerHTML=data.jobs.map(j=>`
 <div class="job-card">
 <h3>${j.title}</h3>
 <p>Category: ${j.category}</p>
 <p>Type: ${j.type}</p>
 <p>Reward: ${j.reward}</p>
 <a href="${j.apply_url||'#'}">Apply</a>
 </div>
 `).join('');
}

loadJobs();
""")
    print("Created jobs.js")
else:
    s=p.read_text()

    if "/api/external/jobs-feed" not in s:
        s += """

async function loadExternalJobs(){
 const r=await fetch('/api/external/jobs-feed');
 const data=await r.json();

 const box=document.getElementById('jobs');

 if(box && data.jobs){
 box.innerHTML=data.jobs.map(j=>`
 <div class="job-card">
 <h3>${j.title}</h3>
 <p>${j.category}</p>
 <p>${j.type}</p>
 <p>${j.reward}</p>
 </div>
 `).join('');
 }
}

loadExternalJobs();
"""
        p.write_text(s)
        print("Updated jobs.js")
    else:
        print("Already connected")
PY

git add .
git commit -m "Connect learner jobs page with external opportunities" || true
git push

vercel --prod

echo "=== Completed ==="
