const db=require("../database");


module.exports=async(req,res)=>{


const investor_id=req.query.investor_id;


const preferences=await db

.from("investor_preferences")

.select("*")

.eq("investor_id",investor_id)

.single();



const opportunities=await db

.from("funding_requests")

.select("*");



let recommendations=(opportunities.data||[])

.map(item=>{


let score=50;


if(preferences.data){

if(
Number(preferences.data.investment_capacity||0)
>=
Number(item.funding_amount||0)
){

score+=30;

}

}


return {

business_id:item.business_id,

funding_id:item.id,

score:Math.min(score,100),

risk_rating:
score>70?"Medium":"High",

reason:
"Matched using investment capacity and opportunity data"

};


})

.sort((a,b)=>b.score-a.score);



let report=

"AI Investment Advisor Report\n\n"+

"Recommended Opportunities: "

+recommendations.length;



await db

.from("ai_advisor_reports")

.insert([{

investor_id,

report

}]);



res.json({

success:true,

report,

recommendations

});


};
