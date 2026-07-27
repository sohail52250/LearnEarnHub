const db=require("../database");


module.exports=async(req,res)=>{


const job_id=req.query.job_id;


const job=await db

.from("enterprise_jobs")

.select("*")

.eq("id",job_id)

.single();



const learners=await db

.from("learner_profiles")

.select("*");



let required=(job.data?.skills||"")
.toLowerCase();



let matches=(learners.data||[])

.map(l=>{


let skills=(

(l.skills||"")
+" "+
(l.bio||"")

).toLowerCase();



let score=0;


required
.split(" ")
.filter(x=>x.length>2)
.forEach(word=>{

if(skills.includes(word))
score+=10;

});


if(score>100)
score=100;


return {

learner:l,

match_score:score

};


})


.sort((a,b)=>
b.match_score-a.match_score
);



res.json({

success:true,

matches

});


};
