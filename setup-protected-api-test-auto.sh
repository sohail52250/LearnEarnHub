#!/data/data/com.termux/files/usr/bin/bash

echo "=== Creating protected API test route ==="

mkdir -p api/developer

cat > api/developer/protected-test.js <<'JS'
module.exports=async(req,res)=>{

 res.json({
  success:true,
  message:"Protected API access granted",
  developer:req.apiKey?.name || null,
  key_id:req.apiKey?.id || null,
  time:new Date()
 });

};
JS

python - <<'PY'
from pathlib import Path

p=Path("server.js")
s=p.read_text()

if '"/api/developer/protected-test"' not in s:

    insert='''
const apiKeySecurity=require("./middleware/api-key-security");

app.get(
 "/api/developer/protected-test",
 apiKeySecurity,
 require("./api/developer/protected-test")
);
'''

    s=s.replace(
        "module.exports = app;",
        insert+"\nmodule.exports = app;"
    )

    p.write_text(s)
    print("Protected route added")
else:
    print("Already exists")

PY

git add .
git commit -m "Add protected API key test endpoint"
git push

echo "=== Completed ==="
