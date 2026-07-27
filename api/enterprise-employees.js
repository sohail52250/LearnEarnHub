const db=require("../database");


module.exports=async(req,res)=>{


if(req.method==="GET"){


const enterprise_id=req.query.enterprise_id;


const {data,error}=await db
.from("enterprise_employees")
.select("*")
.eq("enterprise_id",enterprise_id);


return res.json({

success:true,

data,

error

});


}



if(req.method==="POST"){


const {
enterprise_id,
employee_id,
role
}=req.body;


const {data,error}=await db
.from("enterprise_employees")
.insert([{

enterprise_id,
employee_id,
role

}])
.select();


return res.json({

success:!error,

data,

error

});


}


};
