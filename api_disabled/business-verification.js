
const db=require("../database");


module.exports=async(req,res)=>{


if(req.method==="GET"){


const user_id=req.query.user_id;


const {data,error}=await db

.from("business_verifications")

.select("*")

.eq("user_id",user_id);


return res.json({

success:true,

data,

error

});


}



if(req.method==="POST"){


const {

user_id,

company_name,

registration_number,

document_url

}=req.body;


const {data,error}=await db

.from("business_verifications")

.insert([{

user_id,

company_name,

registration_number,

document_url

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

