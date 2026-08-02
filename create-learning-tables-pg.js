require("dotenv").config();
const {Client}=require("pg");

const client=new Client({
 connectionString: process.env.DATABASE_URL
});

const sql=`
CREATE TABLE IF NOT EXISTS learning_progress (
 id BIGSERIAL PRIMARY KEY,
 user_id UUID NOT NULL,
 course_id BIGINT REFERENCES courses(id) ON DELETE CASCADE,
 lesson_id BIGINT REFERENCES course_lessons(id) ON DELETE CASCADE,
 completed BOOLEAN DEFAULT false,
 completed_at TIMESTAMP DEFAULT NULL,
 created_at TIMESTAMP DEFAULT NOW(),
 UNIQUE(user_id,lesson_id)
);

CREATE TABLE IF NOT EXISTS course_completion (
 id BIGSERIAL PRIMARY KEY,
 user_id UUID NOT NULL,
 course_id BIGINT REFERENCES courses(id) ON DELETE CASCADE,
 completed_at TIMESTAMP DEFAULT NOW(),
 UNIQUE(user_id,course_id)
);
`;

(async()=>{
try{
await client.connect();
await client.query(sql);
console.log("✅ Learning tables created");
}catch(e){
console.log("❌",e.message);
}finally{
await client.end();
}
})();
