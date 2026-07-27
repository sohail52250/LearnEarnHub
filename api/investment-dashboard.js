const db=require("../database");


module.exports=async(req,res)=>{


const investor_id=req.query.investor_id;


const investments=await db

.from("investments")

.select("*")

.eq("investor_id",investor_id);



const returns=await db

.from("investment_returns")

.select("*");



let totalInvestment=0;


(investments.data||[])

.forEach(i=>{

totalInvestment += Number(i.amount||0);

});



let totalReturn=0;


(returns.data||[])

.forEach(r=>{

totalReturn += Number(r.return_amount||0);

});



res.json({

success:true,

portfolio:{

total_investment:totalInvestment,

total_returns:totalReturn,

active_investments:
(investments.data||[]).length

},

investments:
investments.data||[]

});


};
