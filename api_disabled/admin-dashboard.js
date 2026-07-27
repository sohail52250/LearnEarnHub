const db=require("../database");

module.exports=async(req,res)=>{

const users=await db
.from("users")
.select("id",{count:"exact"});

const courses=await db
.from("courses")
.select("id",{count:"exact"});

const tasks=await db
.from("earning_tasks")
.select("id",{count:"exact"});


return res.json({
success:true,
statistics:{
users:users.count || 0,
courses:courses.count || 0,
tasks:tasks.count || 0
}
});

};
