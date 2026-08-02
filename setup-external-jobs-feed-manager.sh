#!/data/data/com.termux/files/usr/bin/bash

echo "=== Adding External Jobs Feed Manager ==="

mkdir -p api/external


cat > api/external/jobs-feed.js <<'JS'
module.exports=async(req,res)=>{

try{

const category=req.query.category || "all";


const jobs=[

{
source:"External Feed",
title:"Remote Data Entry Opportunities",
category:"data-entry",
type:"remote",
reward:"Variable",
apply_url:""
},

{
source:"External Feed",
title:"Freelance Digital Tasks",
category:"freelance",
type:"online",
reward:"Variable",
apply_url:""
},

{
source:"External Feed",
title:"Online Marketing Tasks",
category:"marketing",
type:"remote",
reward:"Variable",
apply_url:""
}

];


let result=
category==="all"
?
jobs
:
jobs.filter(j=>j.category===category);


res.json({
success:true,
category,
jobs:result
});


}catch(e){

res.status(500).json({
error:e.message
});

}

};
JS


python - <<'PY'
from pathlib import Path

p=Path("server.js")
s=p.read_text()

if "/api/external/jobs-feed" not in s:

 s += '''

const externalJobsFeed=require("./api/external/jobs-feed");

app.get(
 "/api/external/jobs-feed",
 externalJobsFeed
);
'''

 p.write_text(s)

 print("External jobs feed route added")

else:
 print("Already exists")

PY


git add .
git commit -m "Add external jobs feed manager" || true
git push

vercel --prod

echo "=== Completed ==="
