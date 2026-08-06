#!/data/data/com.termux/files/usr/bin/bash

echo "=== Improving Opportunity Link Handling ==="

python - <<'PY'
from pathlib import Path

p=Path("public/opportunities.html")

if not p.exists():
    print("opportunities.html not found")
    raise SystemExit(1)

s=p.read_text()

s=s.replace(
'''${j.url?
`<a href="${j.url}" target="_blank">
<button>Apply</button>
</a>`:
"<button disabled>Coming Soon</button>"
}''',
'''${j.url && j.url.startsWith("http")?
`<a href="${j.url}" target="_blank" rel="noopener">
<button>Apply Now</button>
</a>`:
"<button disabled>No application link available</button>"
}'''
)

p.write_text(s)

print("Opportunity buttons updated")
PY


mkdir -p api/external

cat > api/external/jobs-feed.js <<'JS'
module.exports=(req,res)=>{
res.json({
success:true,
category:req.query.category||"all",
jobs:[
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
]
});
};
JS


git add .
git commit -m "Improve opportunity apply link handling" || true
git push

vercel --prod

echo "=== Completed ==="
