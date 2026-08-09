require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);


async function analyzeJobs(){

const {data:jobs}=await db
.from("imported_jobs")
.select("*")
.eq("status","active");


for(const job of jobs || []){


let skills=[];

let text=
`${job.title} ${job.description}`
.toLowerCase();



if(text.includes("ai"))
skills.push("AI");


if(text.includes("web"))
skills.push("Web Development");


if(text.includes("write"))
skills.push("Content Writing");


if(text.includes("data"))
skills.push("Data Entry");



await db
.from("imported_jobs")
.update({
skills
})
.eq("id",job.id);


console.log(
"Analyzed:",
job.title,
skills
);


}


console.log("AI analysis complete");

}


analyzeJobs();

