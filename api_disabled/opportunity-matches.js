
const db=require("../database");


module.exports=async(req,res)=>{


if(req.method==="GET"){


const user_id=req.query.user_id;



const profile=await db
.from("learner_cv_profiles")
.select("technical_skills,soft_skills")
.eq("user_id",user_id)
.single();



const opportunities=await db
.from("business_opportunities")
.select("*")
.eq("approved",true);



let skills=((profile.data?.technical_skills||"")
+" "+
(profile.data?.soft_skills||""))
.toLowerCase();



let result=(opportunities.data||[])
.map(o=>{


let text=(
(o.title||"")+
" "+
(o.description||"")+
" "+
(o.category||"")
).toLowerCase();


let score=0;


skills.split(" ")
.filter(x=>x.length>3)
.forEach(word=>{

if(text.includes(word))
score+=10;

});


if(score>100)
score=100;


return {
...o,
match_score:score
};


})
.sort((a,b)=>b.match_score-a.match_score);



return res.json({

success:true,

matches:result

});


}



if(req.method==="POST"){


const {
user_id,
opportunity_id,
message
}=req.body;



const {data,error}=await db
.from("opportunity_applications")
.insert([{

user_id,
opportunity_id,
message

}])
.select();



return res.json({

success:!error,

data,

error

});


}


res.status(405).json({
error:"Method not allowed"
});


};

