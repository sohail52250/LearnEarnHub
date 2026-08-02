require("dotenv").config();
const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);

const targets={
8:"AI Career Guide",
67:"Microsoft Word Basics"
};

async function run(){

for(const id in targets){

const courseId=Number(id);

const {data:lessons,error}=await db
.from("course_lessons")
.select("lesson_number")
.eq("course_id",courseId)
.order("lesson_number");

if(error){
console.log(error);
continue;
}

let current=lessons.length;
console.log("\n",targets[id]);
console.log("Existing lessons:",current);

let add=[];

for(let i=current+1;i<=15;i++){

add.push({
course_id:courseId,
lesson_number:i,
title:`Lesson ${i}: ${targets[id]}`,
content:`Complete lesson content for ${targets[id]} - Lesson ${i}. Learn practical skills and apply them with examples.`,
});

}

if(add.length){

const {error:insertError}=await db
.from("course_lessons")
.insert(add);

console.log(
insertError ? insertError : 
"Added lessons:",add.length
);

}else{

console.log("Already complete");

}

}

}

run();
