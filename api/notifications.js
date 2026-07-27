
const db=require("../database");

module.exports=async(req,res)=>{


if(req.method==="GET"){

const {data,error}=await db
.from("notifications")
.select("*")
.order("created_at",{ascending:false});


return res.json({
data,error
});

}



if(req.method==="POST"){

const {user_id,title,message}=req.body;


const {data,error}=await db
.from("notifications")
.insert([{
user_id,
title,
message
}])
.select();


return res.json({
success:!error,
data,error
});


}


res.status(405).json({
error:"Method not allowed"
});


};

