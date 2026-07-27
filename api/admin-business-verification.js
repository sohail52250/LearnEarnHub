const db=require("../database");

module.exports=async(req,res)=>{


if(req.method==="GET"){


const {data,error}=await db

.from("business_verifications")

.select("*")

.order("created_at",{ascending:false});


return res.json({

success:true,

data,

error

});


}



if(req.method==="POST"){


const {

id,

status,

trust_score,

admin_note

}=req.body;


const {data,error}=await db

.from("business_verifications")

.update({

status,

trust_score,

admin_note,

updated_at:new Date()

})

.eq("id",id)

.select();


if(status==="approved"){

await db

.from("business_profiles_complete")

.update({

verification_status:"verified"

})

.eq("user_id",data[0].user_id);

}


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
