const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);


module.exports=async function(req,res){

try{

const {
user_id,
course_id,
lesson_id
}=req.body;


if(!user_id || !course_id || !lesson_id){

return res.status(400).json({
error:"Missing required fields"
});

}



const {data,error}=await db
.from("learning_progress")
.upsert([{

user_id,
course_id,
lesson_id,
completed:true,
completed_at:new Date()

}],{

onConflict:"user_id,lesson_id"

})
.select();



if(error){

return res.status(500).json(error);

}



res.json({

success:true,
message:"Lesson completed",
progress:data

});


}catch(e){

res.status(500).json({
error:e.message
});

}

};
