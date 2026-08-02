#!/data/data/com.termux/files/usr/bin/bash

echo "=== Adding Apply Button To Marketplace ==="

python - <<'PY'
from pathlib import Path

p=Path("public/task-marketplace.html")

s=p.read_text()

if "applyExternalJob" not in s:

    s=s.replace(
    '${j.apply?\\n`<a href="${j.apply}" target="_blank">\\nApply Now\\n</a>`:""}',
    '''
<button onclick='applyExternalJob(${JSON.stringify(j)})'>
Save / Apply
</button>

${j.apply?
`<a href="${j.apply}" target="_blank">
Open Platform
</a>`:""}
'''
    )

    addon="""

<script>

async function applyExternalJob(job){

let user_id=localStorage.getItem("user_id");

if(!user_id){

alert("Please login first");
return;

}


let r=await fetch("/api/jobs/apply",{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

job_title:job.title,
source:job.source,
apply_url:job.apply,
user_id:user_id

})

});


let data=await r.json();


if(data.success){

alert("Opportunity saved successfully");

}else{

alert(data.error || "Failed");

}

}

</script>

"""

    s=s.replace("</body>",addon+"</body>")

    p.write_text(s)

    print("Apply button added")

else:
    print("Already added")

PY


git add .
git commit -m "Add marketplace apply button" || true
git push

vercel --prod

echo "=== Completed ==="
