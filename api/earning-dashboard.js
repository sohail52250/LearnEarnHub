
const db=require("../database");


module.exports=async(req,res)=>{

const user_id=req.query.user_id;


const wallet=await db
.from("wallets")
.select("*")
.eq("user_id",user_id);


const history=await db
.from("wallet_transactions")
.select("*")
.eq("user_id",user_id)
.order("created_at",{ascending:false});


res.json({

success:true,

wallet:wallet.data,

transactions:history.data

});


};

