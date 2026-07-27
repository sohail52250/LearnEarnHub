const db=require("../database");

module.exports=async(req,res)=>{

const enterprise_id=req.query.enterprise_id;


const employees=await db
.from("enterprise_employees")
.select("*")
.eq("enterprise_id",enterprise_id);


const training=await db
.from("enterprise_course_assignments")
.select("*")
.eq("enterprise_id",enterprise_id);


let total=training.data?.length || 0;

let completed=(training.data||[])
.filter(x=>x.status==="completed")
.length;


let progress=0;

if(total>0){
progress=Math.round((completed/total)*100);
}


res.json({

success:true,

analytics:{

employees:employees.data?.length || 0,

assigned_courses:total,

completed_courses:completed,

completion_rate:progress

}

});


};
