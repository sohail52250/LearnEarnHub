const db=require("../database");

module.exports=async(req,res)=>{

const user_id=req.query.user_id;


const {data}=await db
.from("learner_cv_profiles")
.select("*")
.eq("user_id",user_id)
.single();


if(!data)
return res.json({
percentage:0
});


let fields=[
"full_name",
"headline",
"bio",
"education",
"experience",
"technical_skills",
"soft_skills",
"projects",
"certifications",
"languages"
];


let completed=fields.filter(
x=>data[x]
).length;


let percentage=Math.round(
(completed/fields.length)*100
);


res.json({
percentage,
completed,
total:fields.length
});


};
