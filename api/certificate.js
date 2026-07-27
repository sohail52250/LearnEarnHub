const db = require("../database");

module.exports = async (req,res)=>{

if(req.method !== "GET"){
return res.status(405).json({
error:"GET only"
});
}


const {user_id}=req.query;


if(!user_id){
return res.status(400).json({
error:"missing user_id"
});
}


const {data,error}=await db
.from("certificates")
.select("*")
.eq("user_id",user_id);


return res.json({
success:!error,
data,
error
});

};
