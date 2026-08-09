require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function stats(){


const {count:users}=await db
.from("users")
.select("*",{count:"exact",head:true});


const {count:courses}=await db
.from("courses")
.select("*",{count:"exact",head:true});


const {count:lessons}=await db
.from("course_lessons")
.select("*",{count:"exact",head:true});


const {count:certificates}=await db
.from("certificates")
.select("*",{count:"exact",head:true});


return {

users:users||0,

courses:courses||0,

lessons:lessons||0,

certificates:certificates||0

};


}



async function courses(){


const {data,error}=await db
.from("courses")
.select("id,title_en,category")
.order("id");


if(error) throw error;


return data;


}



module.exports={
stats,
courses
};

