const db = require("../database");

module.exports = async(req,res)=>{

if(req.method==="GET"){

const {data,error}=await db
.from("learner_skills")
.select("*");

return res.json({
data,
error
});

}


if(req.method==="POST"){

const {
user_id,
skill,
level
}=req.body;


const {data,error}=await db
.from("learner_skills")
.insert([{
user_id,
skill,
level:level || "Beginner"
}])
.select();


return res.json({
success:!error,
data,
error
});

}


return res.status(405).json({
error:"Method not allowed"
});

};
