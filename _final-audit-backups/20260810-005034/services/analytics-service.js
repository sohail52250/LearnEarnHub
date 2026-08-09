require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function dashboardStats(){


const {count:users}=await db
.from("profiles")
.select("*",{count:"exact",head:true});



const {count:courses}=await db
.from("courses")
.select("*",{count:"exact",head:true});



const {count:lessons}=await db
.from("course_lessons")
.select("*",{count:"exact",head:true});



const {count:progress}=await db
.from("learning_progress")
.select("*",{count:"exact",head:true})
.eq("completed",true);



const {count:certificates}=await db
.from("certificates")
.select("*",{count:"exact",head:true});



return {

total_users:users||0,

total_courses:courses||0,

total_lessons:lessons||0,

completed_lessons:progress||0,

certificates:certificates||0

};


}



async function categoryReport(){


const {data,error}=await db
.from("courses")
.select("category");


if(error) throw error;



let result={};


data.forEach(x=>{

let c=x.category || "Other";

result[c]=(result[c]||0)+1;

});


return result;


}



module.exports={
dashboardStats,
categoryReport
};

