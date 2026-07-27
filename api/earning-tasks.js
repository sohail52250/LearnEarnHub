const db=require("../database");

module.exports=async(req,res)=>{

if(req.method==="GET"){

const {data,error}=await db
.from("earning_tasks")
.select("*")
.order("created_at",{ascending:false});

return res.json({data,error});

}


if(req.method==="POST"){

const {data,error}=await db
.from("earning_tasks")
.insert([req.body])
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
