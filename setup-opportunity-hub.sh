#!/data/data/com.termux/files/usr/bin/bash

echo "=== Creating Opportunity Hub ==="

mkdir -p public/opportunities

cat > public/opportunities/index.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>LearnEarnHub Opportunities</title>
<meta name="viewport" content="width=device-width,initial-scale=1">
<style>
body{font-family:Arial;padding:20px}
.card{border:1px solid #ddd;padding:15px;margin:10px;border-radius:10px}
button{padding:10px}
</style>
</head>
<body>

<h1>Available Jobs & Tasks</h1>

<div id="jobs">Loading...</div>

<script>
fetch("/api/external/jobs-feed")
.then(r=>r.json())
.then(data=>{
let box=document.getElementById("jobs");

box.innerHTML=data.jobs.map(j=>`
<div class="card">
<h3>${j.title}</h3>
<p>Source: ${j.source}</p>
<p>Category: ${j.category}</p>
<p>Reward: ${j.reward}</p>
<p>Verification: ⚠️ External Source</p>

${j.apply_url?
`<a href="${j.apply_url}" target="_blank">
<button>Apply Now</button>
</a>`
:
`<button disabled>No Apply Link</button>`
}

</div>
`).join("");
});
</script>

</body>
</html>
HTML


python - <<'PY'
from pathlib import Path

p=Path("public/index.html")

if p.exists():
    s=p.read_text()

    if "Latest Jobs & Tasks" not in s:
        s += '''
<section>
<h2>Latest Jobs & Tasks</h2>
<p>Find remote jobs, freelance tasks and earning opportunities.</p>
<a href="/opportunities/index.html">
<button>View Opportunities</button>
</a>
</section>
'''
        p.write_text(s)

print("Homepage opportunity link added")
PY


git add .
git commit -m "Add opportunity hub page and homepage visibility" || true
git push

vercel --prod

echo "=== Completed ==="
