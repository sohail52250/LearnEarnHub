#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub Admin + Instructor Upgrade"
echo "======================================"

mkdir -p database


cat > database/admin_instructor_upgrade.sql <<'SQL'

CREATE TABLE IF NOT EXISTS instructors (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid REFERENCES users(id) ON DELETE CASCADE,
bio text,
skills text,
verified boolean DEFAULT false,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS instructor_courses (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
instructor_id uuid REFERENCES instructors(id) ON DELETE CASCADE,
course_id uuid REFERENCES courses(id) ON DELETE CASCADE,
status text DEFAULT 'pending',
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS course_reviews (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
course_id uuid REFERENCES courses(id) ON DELETE CASCADE,
admin_id uuid,
status text DEFAULT 'pending',
review_notes text,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS admin_logs (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
admin_id uuid,
action text,
details text,
created_at timestamp DEFAULT now()
);

SQL


echo "Creating instructor API..."

cat > api/instructor-course.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

if(req.method==="POST"){

const {
instructor_id,
course_id
}=req.body;


const {data,error}=await db
.from("instructor_courses")
.insert([{
instructor_id,
course_id,
status:"pending"
}])
.select();


return res.json({
success:!error,
data,
error
});

}


if(req.method==="GET"){

const instructor_id=req.query.instructor_id;


const {data,error}=await db
.from("instructor_courses")
.select("*")
.eq("instructor_id",instructor_id);


return res.json({
data,
error
});

}


return res.status(405).json({
error:"Method not allowed"
});

};
JS



echo "Creating admin review API..."

cat > api/admin-course-review.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

if(req.method!=="POST"){
return res.status(405).json({
error:"POST only"
});
}


const {
course_id,
admin_id,
status,
review_notes
}=req.body;


const {data,error}=await db
.from("course_reviews")
.insert([{
course_id,
admin_id,
status,
review_notes
}])
.select();


return res.json({
success:!error,
data,
error
});

};
JS



echo "Creating instructor dashboard API..."

cat > api/instructor-dashboard.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

const instructor_id=req.query.instructor_id;


const {data,error}=await db
.from("instructor_courses")
.select(`
id,
status,
course_id,
courses(*)
`)
.eq("instructor_id",instructor_id);


return res.json({
success:!error,
data,
error
});

};
JS



echo "Creating admin logs API..."

cat > api/admin-log.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

const {admin_id,action,details}=req.body;


const {data,error}=await db
.from("admin_logs")
.insert([{
admin_id,
action,
details
}])
.select();


return res.json({
success:!error,
data,
error
});

};
JS



git add database/admin_instructor_upgrade.sql api/instructor-course.js api/admin-course-review.js api/instructor-dashboard.js api/admin-log.js

git commit -m "Add admin and instructor course management system" || true

git push


echo "======================================"
echo " Admin + Instructor System Added"
echo "======================================"

echo "Run SQL:"
echo "database/admin_instructor_upgrade.sql"

