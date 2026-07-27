const db=require("../database");

module.exports=async(req,res)=>{


if(req.method==="GET"){

const investor_id=req.query.investor_id;


const verification=await db
.from("investor_verification")
.select("*")
.eq("investor_id",investor_id);


const documents=await db
.from("compliance_documents")
.select("*")
.eq("user_id",investor_id);


return res.json({

success:true,

verification:verification.data||[],

documents:documents.data||[]

});

}


if(req.method==="POST"){


const {data,error}=await db

.from("compliance_logs")

.insert([req.body])

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
