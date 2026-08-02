#!/data/data/com.termux/files/usr/bin/bash

echo "=== Adding Marketplace Filters ==="

python - <<'PY'
from pathlib import Path

p=Path("public/task-marketplace.html")

if not p.exists():
    print("task-marketplace.html not found")
    raise SystemExit()

s=p.read_text()

if "job-search-filter" not in s:

    addon="""

<h2>Find Opportunities</h2>

<input id="job-search-filter" placeholder="Search jobs..." 
style="width:100%;padding:10px">

<select id="job-country-filter" style="width:100%;padding:10px;margin-top:8px">
<option value="">All Countries</option>
<option>Pakistan</option>
<option>Remote</option>
<option>Worldwide</option>
</select>

<button onclick="loadExternalJobs()" 
style="padding:10px;margin-top:8px">
Refresh Opportunities
</button>

<div id="external-jobs-container">
Loading opportunities...
</div>

<script>

let allExternalJobs=[];

async function loadExternalJobs(){

const box=document.getElementById("external-jobs-container");

try{

let r=await fetch("/api/external/jobs-feed");
let data=await r.json();

allExternalJobs=data.jobs||[];

displayExternalJobs();

}catch(e){

box.innerHTML="Unable to load opportunities";

}

}


function displayExternalJobs(){

let search=document
.getElementById("job-search-filter")
.value.toLowerCase();

let country=document
.getElementById("job-country-filter")
.value.toLowerCase();


let jobs=allExternalJobs.filter(j=>{

let text=(j.title+" "+(j.company||"")+" "+(j.source||""))
.toLowerCase();

let matchSearch=!search || text.includes(search);

let matchCountry=!country ||
(j.country||"").toLowerCase().includes(country);

return matchSearch && matchCountry;

});


document.getElementById("external-jobs-container").innerHTML=
jobs.map(j=>`

<div style="border:1px solid #ddd;padding:12px;margin:10px;border-radius:8px">

<h3>${j.title||"Opportunity"}</h3>

<p>Source: ${j.source||""}</p>

<p>Company: ${j.company||"Unknown"}</p>

${j.apply?
`<a href="${j.apply}" target="_blank">
Apply Now
</a>`:""}

</div>

`).join("") || "No matching opportunities";


}


document
.getElementById("job-search-filter")
.addEventListener("input",displayExternalJobs);

document
.getElementById("job-country-filter")
.addEventListener("change",displayExternalJobs);


loadExternalJobs();

</script>

"""

    s=s.replace("</body>",addon+"</body>")
    p.write_text(s)

    print("Filters added")

else:
    print("Already exists")

PY

git add .
git commit -m "Add opportunity search filters" || true
git push

vercel --prod

echo "=== Done ==="
