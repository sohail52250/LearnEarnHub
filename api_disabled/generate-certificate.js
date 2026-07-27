const db=require("../database");

module.exports=async(req,res)=>{

const {
user_id,
course_id
}=req.body;


const code="LEH-"+Date.now();


const {data,error}=await db
.from("certificates")
.insert([{
user_id,
course_id,
certificate_code:code,
certificate_title:"LearnEarnHub Course Certificate"
}])
.select();


return res.json({
success:!error,
certificate:data,
error
});

};
