#!/data/data/com.termux/files/usr/bin/bash

echo "=== Connecting Marketplace to External Feed ==="

TARGET="public/task-marketplace.html"

if [ ! -f "$TARGET" ]; then
  echo "task-marketplace.html not found"
  exit 1
fi

python - <<'PY'
from pathlib import Path

p=Path("public/task-marketplace.html")
s=p.read_text()

if 'external-jobs-container' not in s:

    widget = """
<h2>External Opportunities</h2>
<div id="external-jobs-container">
Loading opportunities...
</div>

<script>
async function loadExternalJobs(){

 try{

  const r = await fetch("/api/external/jobs-feed");
  const data = await r.json();

  const box=document.getElementById("external-jobs-container");

  if(!data.jobs || !data.jobs.length){
    box.innerHTML="<p>No opportunities available.</p>";
    return;
  }

  box.innerHTML=data.jobs.map(job=>`
    <div style="border:1px solid #ddd;padding:12px;margin:10px 0;border-radius:8px">
      <h3>${job.title || "Opportunity"}</h3>
      <p><b>Source:</b> ${job.source || ""}</p>
      <p><b>Company:</b> ${job.company || "N/A"}</p>
      ${job.apply ? `<a href="${job.apply}" target="_blank">Apply Now</a>` : ""}
    </div>
  `).join("");

 }catch(e){
   document.getElementById("external-jobs-container").innerHTML =
   "<p>Unable to load opportunities.</p>";
 }

}

loadExternalJobs();
</script>
"""

    if "</body>" in s:
        s=s.replace("</body>",widget+"\n</body>")

    p.write_text(s)
    print("Marketplace updated")

else:
    print("Already connected")
PY

git add .
git commit -m "Connect marketplace to external opportunities" || true
git push
vercel --prod

echo "=== Completed ==="
