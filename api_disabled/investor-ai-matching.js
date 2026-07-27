const db=require("../database");


module.exports=async(req,res)=>{


const funding_id=req.query.funding_id;


const funding=await db

.from("funding_requests")

.select("*")

.eq("id",funding_id)

.single();



const investors=await db

.from("investor_profiles")

.select("*");



let results=(investors.data||[])

.map(investor=>{


let score=0;


if(
Number(investor.investment_range||0)
>=
Number(funding.data?.funding_amount||0)
){

score+=40;

}


if(
investor.industry_focus &&
funding.data?.purpose &&
investor.industry_focus
.toLowerCase()
.includes(
funding.data.purpose.toLowerCase()
)

){

score+=30;

}


score+=30;


return {

investor,

match_score:Math.min(score,100),

reason:
"Investment capacity and business requirements analyzed"

};


})

.sort((a,b)=>
b.match_score-a.match_score
);



res.json({

success:true,

matches:results

});


};
