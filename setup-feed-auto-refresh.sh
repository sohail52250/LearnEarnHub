#!/data/data/com.termux/files/usr/bin/bash

echo "=== Adding Auto Feed Refresh System ==="

mkdir -p api/feeds


cat > api/feeds/refresh.js <<'JS'
const fs=require("fs");
const path=require("path");

const cacheFile=path.join(
process.cwd(),
"api/feeds/feed-cache.json"
);


module.exports=async(req,res)=>{

try{


let jobs=[

{
id:"remote-001",
title:"Remote Work Opportunity",
category:"remote",
source:"External Feed",
reward:"Variable"
},

{
id:"task-001",
title:"Online Digital Task",
category:"tasks",
source:"External Feed",
reward:"Variable"
}

];


// remove duplicates

let unique=[];

let ids=new Set();

jobs.forEach(j=>{

if(!ids.has(j.id)){

ids.add(j.id);
unique.push(j);

}

});


// save cache

fs.writeFileSync(
cacheFile,
JSON.stringify({
updated:new Date(),
jobs:unique
},null,2)
);


res.json({

success:true,
message:"Feed refreshed",
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



cat > api/feeds/list.js <<'JS'
const fs=require("fs");
const path=require("path");

module.exports=async(req,res)=>{

try{

const file=path.join(
process.cwd(),
"api/feeds/feed-cache.json"
);


if(!fs.existsSync(file)){

return res.json({
success:true,
jobs:[]
});

}


let data=JSON.parse(
fs.readFileSync(file)
);


let category=req.query.category;


let jobs=data.jobs||[];


if(category){

jobs=jobs.filter(
j=>j.category===category
);

}


res.json({

success:true,
updated:data.updated,
jobs

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

if "/api/feeds/refresh" not in s:

s_add='''

const feedRefresh=require("./api/feeds/refresh");
const feedList=require("./api/feeds/list");

app.get("/api/feeds/refresh",feedRefresh);

app.get("/api/feeds/list",feedList);

'''

s += s_add
p.write_text(s)

print("Feed routes added")

else:
print("Already exists")

PY



git add .
git commit -m "Add automatic feed refresh and filtering" || true
git push

vercel --prod

echo "=== Completed ==="
