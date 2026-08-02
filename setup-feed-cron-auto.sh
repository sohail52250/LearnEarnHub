#!/data/data/com.termux/files/usr/bin/bash

echo "=== Adding Feed Auto Scheduler ==="

mkdir -p api/cron


cat > api/cron/refresh-feeds.js <<'JS'
module.exports=async(req,res)=>{

try{

const base=
process.env.APP_URL ||
"https://learn-earnhub.vercel.app";


const response=
await fetch(
base+"/api/feeds/refresh"
);


const data=
await response.json();


res.json({

success:true,
scheduler:"active",
result:data

});


}catch(e){

res.status(500).json({
error:e.message
});

}

};
JS



cat > vercel.json <<'JSON'
{
  "crons": [
    {
      "path": "/api/cron/refresh-feeds",
      "schedule": "0 */6 * * *"
    }
  ]
}
JSON



python - <<'PY'
from pathlib import Path

p=Path("server.js")
s=p.read_text()

if "/api/cron/refresh-feeds" not in s:

s += '''

const cronRefresh=require("./api/cron/refresh-feeds");

app.get(
 "/api/cron/refresh-feeds",
 cronRefresh
);

'''

p.write_text(s)

print("Cron route added")

else:
print("Already exists")

PY



git add .
git commit -m "Add automatic feed refresh scheduler" || true
git push

vercel --prod

echo "=== Completed ==="
