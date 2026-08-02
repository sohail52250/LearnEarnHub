require("dotenv").config();
const axios=require("axios");
const fs=require("fs");

(async()=>{

const sql=`
CREATE TABLE IF NOT EXISTS learning_progress (
 id BIGSERIAL PRIMARY KEY,
 user_id UUID NOT NULL,
 course_id BIGINT NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
 lesson_id BIGINT NOT NULL REFERENCES course_lessons(id) ON DELETE CASCADE,
 completed BOOLEAN DEFAULT false,
 completed_at TIMESTAMP DEFAULT NULL,
 created_at TIMESTAMP DEFAULT NOW(),
 UNIQUE(user_id, lesson_id)
);

CREATE TABLE IF NOT EXISTS course_completion (
 id BIGSERIAL PRIMARY KEY,
 user_id UUID NOT NULL,
 course_id BIGINT NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
 completed_at TIMESTAMP DEFAULT NOW(),
 UNIQUE(user_id, course_id)
);

CREATE INDEX IF NOT EXISTS learning_progress_user_idx
ON learning_progress(user_id);

CREATE INDEX IF NOT EXISTS learning_progress_course_idx
ON learning_progress(course_id);
`;

const project="srarnaqyoiqotdntzsyc";

try{

const res=await axios.post(
`https://api.supabase.com/v1/projects/${project}/database/query`,
{
query:sql
},
{
headers:{
Authorization:`Bearer ${process.env.SUPABASE_SERVICE_KEY}`,
apikey:process.env.SUPABASE_SERVICE_KEY,
"Content-Type":"application/json"
}
}
);

console.log("✅ SQL EXECUTED");
console.log(res.data);

}catch(e){

console.log("❌ ERROR");
console.log(
e.response?.data || e.message
);

}

})();
