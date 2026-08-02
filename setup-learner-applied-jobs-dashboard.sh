#!/data/data/com.termux/files/usr/bin/bash

echo "=== Adding My Applied Jobs Section ==="

TARGET="public/learner-dashboard.html"

if [ ! -f "$TARGET" ]; then
 echo "learner-dashboard.html not found"
 exit 1
fi

python - <<'PY'
from pathlib import Path

p=Path("public/learner-dashboard.html")
s=p.read_text()

if "my-applied-jobs" not in s:

 addon=r'''

<section id="my-applied-jobs">
<h2>My Saved Opportunities</h2>

<div id="applied-jobs-list">
Loading...
</div>

</section>


<script>

async function loadMyApplications(){

try{

let sessionData = await supabaseClient.auth.getSession();

let session=sessionData.data.session;

if(!session){
 document.getElementById("applied-jobs-list").innerHTML=
 "Please login to view saved opportunities";
 return;
}


let user=session.user.id;


let r=await fetch(
"/api/jobs/my-applications?user_id="+user
);


let data=await r.json();


let box=document.getElementById("applied-jobs-list");


if(!data.applications || !data.applications.length){

box.innerHTML="No saved opportunities yet";

return;

}


box.innerHTML=data.applications.map(j=>`

<div style="border:1px solid #ddd;padding:12px;margin:10px;border-radius:8px">

<h3>${j.job_title}</h3>

<p>Source: ${j.source}</p>

<p>Status: ${j.status}</p>

<a href="${j.apply_url}" target="_blank">
Open Opportunity
</a>

</div>

`).join("");


}catch(e){

document.getElementById("applied-jobs-list").innerHTML=
"Unable to load opportunities";

}

}


loadMyApplications();

</script>

'''

 s=s.replace("</body>",addon+"</body>")
 p.write_text(s)

 print("Dashboard updated")

else:
 print("Already exists")

PY


git add .
git commit -m "Add learner applied jobs dashboard" || true
git push

vercel --prod

echo "=== Completed ==="
