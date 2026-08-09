require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function createCourse(course){

const {data,error}=await db
.from("courses")
.insert(course)
.select()
.single();

if(error) throw error;

return data;

}



async function updateCourse(id,course){

const {data,error}=await db
.from("courses")
.update(course)
.eq("id",id)
.select()
.single();

if(error) throw error;

return data;

}



async function deleteCourse(id){

const {error}=await db
.from("courses")
.delete()
.eq("id",id);


if(error) throw error;


return {
success:true
};

}



module.exports={
createCourse,
updateCourse,
deleteCourse
};

