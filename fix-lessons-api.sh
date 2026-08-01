#!/bin/bash

echo "=== Checking local route ==="
grep -n "course_lessons" routes/courses.js

echo
echo "=== Checking database columns ==="
psql "$SUPA_DB" -c "
select column_name 
from information_schema.columns
where table_name='course_lessons'
order by ordinal_position;
"

echo
echo "=== Checking lesson count ==="
psql "$SUPA_DB" -c "
select course_id,count(*) 
from course_lessons
where course_id=1
group by course_id;
"

echo
echo "=== Fixing API query ==="

python - <<'PY'
from pathlib import Path

p=Path("routes/courses.js")
s=p.read_text()

start=s.find("// Course lessons API")

if start != -1:
    s=s[:start]

s += r'''
// Course lessons API
router.get("/lessons/:course_id", async(req,res)=>{
    try {
        const courseId = Number(req.params.course_id);

        const {data,error}=await db
            .from("course_lessons")
            .select("*")
            .eq("course_id",courseId)
            .order("lesson_order",{ascending:true});

        if(error){
            console.log(error);
            return res.status(400).json(error);
        }

        res.json(data || []);

    } catch(e){
        res.status(500).json({error:e.message});
    }
});

module.exports=router;
'''

p.write_text(s)

print("API route rebuilt")
PY

echo
echo "=== Commit and deploy ==="

git add routes/courses.js
git commit -m "Fix course lessons API query"
git push origin main

vercel --prod --force

echo
echo "=== Test ==="
sleep 15
curl -s https://learn-earnhub.vercel.app/api/courses/lessons/1 | jq 'length'
