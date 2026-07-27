const db=require("../database");

module.exports=async(req,res)=>{


if(req.method==="GET"){


const enterprise_id=req.query.enterprise_id;


const documents=await db
.from("enterprise_documents")
.select("*")
.eq("enterprise_id",enterprise_id);


const policies=await db
.from("enterprise_policies")
.select("*")
.eq("enterprise_id",enterprise_id);


const logs=await db
.from("enterprise_audit_logs")
.select("*")
.eq("enterprise_id",enterprise_id);


return res.json({

success:true,

documents:documents.data||[],

policies:policies.data||[],

audit_logs:logs.data||[]

});


}



if(req.method==="POST"){


const {

enterprise_id,
document_name,
document_type,
document_url

}=req.body;


const {data,error}=await db

.from("enterprise_documents")

.insert([{

enterprise_id,

document_name,

document_type,

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
