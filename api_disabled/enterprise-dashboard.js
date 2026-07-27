const db=require("../database");

module.exports=async(req,res)=>{

const user_id=req.query.user_id;


const enterprise=await db
.from("enterprises")
.select("*")
.eq("user_id",user_id)
.single();


const employees=await db
.from("enterprise_employees")
.select("*")
.eq("enterprise_id",enterprise.data?.id);


const training=await db
.from("enterprise_training")
.select("*")
.eq("enterprise_id",enterprise.data?.id);


res.json({

success:true,

enterprise:enterprise.data,

employees:employees.data||[],

training:training.data||[]

});


};
