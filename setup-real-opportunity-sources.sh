#!/data/data/com.termux/files/usr/bin/bash

echo "=== Adding External Opportunity Source Manager ==="

mkdir -p api/sources


cat > api/sources/opportunities.js <<'JS'
const sources = [

{
name:"LearnEarnHub Partners",
type:"internal",
enabled:true,
jobs:[
{
title:"Remote Digital Task",
category:"online",
reward:"Variable",
url:""
}
]
},

{
name:"RSS/API Sources",
type:"external",
enabled:false,
jobs:[]
}

];


module.exports=async(req,res)=>{

try{


let all=[];


sources.forEach(source=>{

if(source.enabled){

source.jobs.forEach(job=>{

all.push({

...job,

source:source.name

});

});

}

});


let unique=[];

let seen=new Set();


all.forEach(job=>{

let key=
job.title+"-"+job.source;


if(!seen.has(key)){

seen.add(key);
unique.push(job);

}

});


res.json({

success:true,

sources:sources.length,

count:unique.length,

jobs:unique

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

if "/api/sources/opportunities" not in s:

s += '''

const opportunitiesSource=require("./api/sources/opportunities");

app.get(
 "/api/sources/opportunities",
 opportunitiesSource
);

'''

p.write_text(s)

print("Opportunity source API added")

else:
print("Already exists")

PY



git add .
git commit -m "Add external opportunity source manager" || true
git push

vercel --prod

echo "=== Completed ==="
