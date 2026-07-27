const db=require("../database");


module.exports=async(req,res)=>{


if(req.method==="GET"){


const enterprise_id=req.query.enterprise_id;


const assignments=await db

.from("enterprise_course_assignments")

.select("*")

.eq("enterprise_id",enterprise_id);



return res.json({

success:true,

assignments:assignments.data||[]

});


}



if(req.method==="POST"){


const {

enterprise_id,

employee_id,

course_id

}=req.body;



const {data,error}=await db

.from("enterprise_course_assignments")

.insert([{

enterprise_id,

employee_id,

course_id

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
