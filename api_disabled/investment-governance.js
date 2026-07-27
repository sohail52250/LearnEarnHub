const db=require("../database");

module.exports=async(req,res)=>{


if(req.method==="GET"){

const investment_id=req.query.investment_id;


const approvals=await db
.from("investor_approvals")
.select("*")
.eq("investment_id",investment_id);


const agreements=await db
.from("funding_agreements")
.select("*")
.eq("investment_id",investment_id);


const documents=await db
.from("investment_documents")
.select("*")
.eq("investment_id",investment_id);


return res.json({

success:true,

approvals:approvals.data||[],

agreements:agreements.data||[],

documents:documents.data||[]

});

}


if(req.method==="POST"){


const {data,error}=await db

.from("governance_logs")

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
