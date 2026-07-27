const db=require("../database");

module.exports=async(req,res)=>{


if(req.method==="GET"){

const user_id=req.query.user_id;


const profile=await db
.from("learner_profiles")
.select("*")
.eq("user_id",user_id)
.single();


const badges=await db
.from("learner_badges")
.select("*")
.eq("user_id",user_id);


const progress=await db
.from("lesson_progress")
.select("*")
.eq("user_id",user_id);


res.json({
success:true,
profile:profile.data,
badges:badges.data,
completed_lessons:progress.data?.length || 0
});

}



if(req.method==="POST"){

const {
user_id,
bio,
skills,
education,
experience,
city,
country
}=req.body;


const {data,error}=await db
.from("learner_profiles")
.upsert([{
user_id,
bio,
skills,
education,
experience,
city,
country
}])
.select();


res.json({
success:!error,
data,
error
});

}


res.status(405).json({
error:"Method not allowed"
});

};
