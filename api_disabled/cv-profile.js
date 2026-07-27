
const db=require("../database");


module.exports=async(req,res)=>{


if(req.method==="GET"){

const user_id=req.query.user_id;


const {data,error}=await db
.from("learner_cv_profiles")
.select("*")
.eq("user_id",user_id)
.single();


return res.json({
success:!error,
profile:data,
error
});

}



if(req.method==="POST"){


const profile=req.body;


const {data,error}=await db
.from("learner_cv_profiles")
.upsert([profile])
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

