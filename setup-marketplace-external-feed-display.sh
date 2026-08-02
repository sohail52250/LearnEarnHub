#!/data/data/com.termux/files/usr/bin/bash

echo "=== Connecting External Feed To Marketplace ==="

TARGET="public/task-marketplace.html"

if [ ! -f "$TARGET" ]; then
 echo "task-marketplace.html not found"
 exit 1
fi


python - <<'PY'
from pathlib import Path

p=Path("public/task-marketplace.html")
s=p.read_text()


if "loadExternalJobsFeed" not in s:


addon=r'''

<section id="external-feed">

<h2>Remote Opportunities</h2>

<div id="external-jobs">
Loading opportunities...
</div>

</section>


<script>

async function loadExternalJobsFeed(){

try{

let r=await fetch("/api/external/jobs-feed?category=all");

let data=await r.json();


let box=document.getElementById("external-jobs");


if(!data.jobs || !data.jobs.length){

box.innerHTML="No opportunities available";

return;

}


box.innerHTML=data.jobs.map(j=>`

<div style="border:1px solid #ddd;padding:15px;margin:10px;border-radius:10px">

<h3>${j.title}</h3>

<p>Source: ${j.source}</p>

<p>Type: ${j.type}</p>

<p>Reward: ${j.reward}</p>


<button onclick='saveExternalOpportunity(${JSON.stringify(j)})'>
Save Opportunity
</button>

</div>

`).join("");


}catch(e){

document.getElementById("external-jobs").innerHTML=
"Unable to load opportunities";

}

}



async function saveExternalOpportunity(job){

let {data:{session}} =
await supabaseClient.auth.getSession();


if(!session){

alert("Please login first");
return;

}


let r=await fetch("/api/jobs/apply",{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

user_id:session.user.id,
job_title:job.title,
source:job.source,
apply_url:job.apply_url,
status:"saved"

})

});


let data=await r.json();


alert(
data.success?
"Opportunity saved":
(data.error||"Failed")
);


}


loadExternalJobsFeed();

</script>

'''


s=s.replace("</body>",addon+"</body>")

p.write_text(s)

print("Marketplace external feed connected")

else:

print("Already connected")

PY


git add .
git commit -m "Connect external jobs feed to marketplace" || true
git push

vercel --prod

echo "=== Completed ==="
