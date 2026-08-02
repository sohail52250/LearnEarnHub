#!/data/data/com.termux/files/usr/bin/bash

echo "=== External Jobs Feed Importer ==="

mkdir -p api/external

cat > api/external/jobs-feed.js <<'JS'
module.exports = async (req,res)=>{
try{

const jobs=[];

/*
Future sources:
https://himalayas.app/jobs/api
https://jobicy.com/api/v2/remote-jobs
*/

jobs.push({
 source:"External Feed",
 title:"Remote Opportunity Feed Enabled",
 reward:"Variable",
 type:"remote"
});

res.json({
 success:true,
 jobs
});

}catch(e){
 res.status(500).json({error:e.message});
}
};
JS

python - <<'PY'
from pathlib import Path
p=Path("server.js")
s=p.read_text()

if '/api/external/jobs-feed' not in s:
    s += '''

const externalJobs=require("./api/external/jobs-feed");

app.get(
 "/api/external/jobs-feed",
 externalJobs
);
'''
    p.write_text(s)
    print("External feed route added")
else:
    print("Route already exists")
PY

git add .
git commit -m "Add external jobs feed endpoint" || true
git push
vercel --prod

echo "=== Completed ==="
