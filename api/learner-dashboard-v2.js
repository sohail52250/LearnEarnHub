const db=require("../database");

module.exports=async(req,res)=>{

const user_id=req.query.user_id;


const user=await db
.from("users")
.select("id,name,email,points,language,phone")
.eq("id",user_id)
.single();


const profile=await db
.from("learner_cv_profiles")
.select("*")
.eq("user_id",user_id)
.single();


const courses=await db
.from("lesson_progress")
.select("*")
.eq("user_id",user_id);


const badges=await db
.from("learner_badges")
.select("*")
.eq("user_id",user_id);



let completion=0;

if(profile.data){

let fields=[
"full_name",
"headline",
"bio",
"education",
"experience",
"technical_skills",
"projects",
"certifications"
];

let done=fields.filter(
f=>profile.data[f]
).length;


completion=Math.round(
(done/fields.length)*100
);

}



res.json({

success:true,

user:user.data,

profile:profile.data,

profile_completion:completion,

completed_courses:courses.data?.length || 0,

badges:badges.data || []

});


};
