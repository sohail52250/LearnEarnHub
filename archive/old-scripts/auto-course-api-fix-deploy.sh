#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "===== LEARN EARN HUB AUTO TEST ====="

echo ""
echo "1) Node syntax check"
node --check server.js
node --check routes/courses.js
node --check database.js
echo "OK"

echo ""
echo "2) Local database check"

LESSONS=$(psql "$SUPA_DB" -t -c "select count(*) from course_lessons;" | tr -d ' ')

echo "Database lessons: $LESSONS"

if [ "$LESSONS" -eq 0 ]; then
 echo "ERROR: No lessons in database"
 exit 1
fi

echo "OK"

echo ""
echo "3) Check route"

if grep -q 'router.get("/lessons/:course_id"' routes/courses.js; then
 echo "Lesson route exists"
else
 echo "Route missing - adding"

cat >> routes/courses.js <<'EOF'

router.get("/lessons/:course_id", async(req,res)=>{
 try{
 const {data,error}=await db
 .from("course_lessons")
 .select("*")
 .eq("course_id", Number(req.params.course_id))
 .order("lesson_order",{ascending:true});

 if(error)
 return res.status(400).json(error);

 res.json(data || []);

 }catch(e){
 res.status(500).json({error:e.message});
 }
});

EOF

fi


echo ""
echo "4) Git commit"

git add server.js routes/courses.js

git commit -m "Auto fix course lessons API" || true

git push origin main || true


echo ""
echo "5) Deploy Vercel"

vercel --prod --force


echo ""
echo "Waiting for deployment..."
sleep 15


echo ""
echo "6) Production API test"

RESULT=$(curl -s https://learn-earnhub.vercel.app/api/courses/lessons/1)

echo "$RESULT" | head -c 300

echo ""

COUNT=$(echo "$RESULT" | jq 'length' 2>/dev/null || echo "error")


if [ "$COUNT" = "error" ]; then
 echo "FAILED: API returned invalid JSON"
 exit 1
fi


if [ "$COUNT" -gt 0 ]; then
 echo ""
 echo "SUCCESS: Lessons API working"
else
 echo ""
 echo "WARNING: API returned 0 lessons"
 echo "Checking debug"

 curl -s https://learn-earnhub.vercel.app/api/debug-lessons

fi


echo ""
echo "===== DONE ====="

