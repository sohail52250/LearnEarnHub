require("dotenv").config();
const https = require("https");

const project="srarnaqyoiqotdntzsyc";

const sql = `
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

const data = JSON.stringify({query:sql});

const options={
 hostname:"api.supabase.com",
 path:`/v1/projects/${project}/database/query`,
 method:"POST",
 headers:{
  "Authorization":`Bearer ${process.env.SUPABASE_SERVICE_KEY}`,
  "apikey":process.env.SUPABASE_SERVICE_KEY,
  "Content-Type":"application/json",
  "Content-Length":Buffer.byteLength(data)
 }
};

const req=https.request(options,res=>{
 let body="";
 res.on("data",d=>body+=d);
 res.on("end",()=>{
  console.log("STATUS:",res.statusCode);
  console.log(body);
 });
});

req.on("error",console.error);
req.write(data);
req.end();
