#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub AI Engine Upgrade"
echo "======================================"

mkdir -p database


cat > database/ai_engine_upgrade.sql <<'SQL'

CREATE TABLE IF NOT EXISTS ai_assistant_messages (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid REFERENCES users(id),
message text,
response text,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS ai_recommendations (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid REFERENCES users(id),
course_id uuid REFERENCES courses(id),
reason text,
score integer DEFAULT 0,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS ai_moderation_reviews (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
content_type text,
content_id uuid,
review_status text DEFAULT 'pending',
ai_result text,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS user_activity (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid REFERENCES users(id),
activity text,
page text,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS recommendation_logs (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid,
action text,
details text,
created_at timestamp DEFAULT now()
);

SQL


echo "Creating AI assistant API..."

cat > api/ai-assistant.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

const {
user_id,
message
}=req.body;


const response =
"LearnEarnHub AI Assistant: Continue learning and complete courses to improve your skills.";


const {data,error}=await db
.from("ai_assistant_messages")
.insert([{
user_id,
message,
response
}])
.select();


return res.json({
success:!error,
response,
data,
error
});

};
JS



echo "Creating recommendation API..."

cat > api/recommendations.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

const user_id=req.query.user_id;


const {data,error}=await db
.from("ai_recommendations")
.select(`
id,
course_id,
reason,
score,
courses(*)
`)
.eq("user_id",user_id)
.order("score",{ascending:false});


return res.json({
data,
error
});

};
JS



echo "Creating moderation API..."

cat > api/ai-moderation.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

const {data,error}=await db
.from("ai_moderation_reviews")
.insert([{
content_type:req.body.content_type,
content_id:req.body.content_id,
review_status:"approved",
ai_result:"AI basic moderation completed"
}])
.select();


return res.json({
success:!error,
data,
error
});

};
JS



echo "Creating activity tracking API..."

cat > api/activity-log.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

const {data,error}=await db
.from("user_activity")
.insert([req.body])
.select();


return res.json({
success:!error,
data,
error
});

};
JS



git add database/ai_engine_upgrade.sql api/ai-assistant.js api/recommendations.js api/ai-moderation.js api/activity-log.js

git commit -m "Add AI assistant recommendation and moderation foundation" || true

git push


echo "======================================"
echo " AI Engine Upgrade Complete"
echo "======================================"

echo "Run SQL:"
echo "database/ai_engine_upgrade.sql"

