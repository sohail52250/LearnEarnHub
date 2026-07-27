
const db=require("../database");


module.exports=async(req,res)=>{


if(req.method==="GET"){

const user_id=req.query.user_id;


const {data,error}=await db
.from("wallets")
.select("*")
.eq("user_id",user_id)
.single();


return res.json({
success:!error,
wallet:data,
error
});

}



if(req.method==="POST"){

const {
user_id,
points,
amount_pkr,
description
}=req.body;


const {data,error}=await db
.from("wallet_transactions")
.insert([{
user_id,
type:"credit",
points,
amount_pkr,
description
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

