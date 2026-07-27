const db=require("../database");

module.exports=async(req,res)=>{

if(req.method==="GET"){

const user_id=req.query.user_id;

const {data,error}=await db
.from("messages")
.select("*");

return res.json({success:true,data,error});
}

if(req.method==="POST"){

const {data,error}=await db
.from("messages")
.insert([req.body])
.select();

return res.json({
success:!error,
data,
error
});
}

res.status(405).json({error:"Method not allowed"});
};
