const db=require("../database");


module.exports=async(req,res)=>{


const investor_id=req.query.investor_id;


const investments=await db

.from("investments")

.select("*")

.eq("investor_id",investor_id);



let totalInvestment=0;


(investments.data||[]).forEach(i=>{

totalInvestment += Number(i.amount||0);

});


const returns=await db

.from("investment_returns")

.select("*");


let totalReturn=0;


(returns.data||[]).forEach(r=>{

totalReturn += Number(r.return_amount||0);

});


let roi=0;


if(totalInvestment>0){

roi=((totalReturn-totalInvestment)/totalInvestment)*100;

}


let risk=

roi>20 ?

"Low Risk / Strong Performance":

roi>0 ?

"Moderate Risk":

"High Risk";


const report={

total_investment:totalInvestment,

total_return:totalReturn,

roi_percent:
roi.toFixed(2),

risk_level:risk,

generated:
new Date()

};



await db

.from("investment_reports")

.insert([{

investor_id,

report_type:"performance",

total_investment:totalInvestment,

total_return:totalReturn,

roi_percent:roi,

risk_level:risk,

summary:
JSON.stringify(report)

}]);



res.json({

success:true,

report

});


};
