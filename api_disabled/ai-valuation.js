const db=require("../database");


module.exports=async(req,res)=>{


if(req.method==="POST"){


const {

business_id,

revenue,

profit,

assets,

risk_score

}=req.body;



let baseValue=

(Number(profit||0)*5)+

Number(assets||0);



let adjustment=

100-risk_score;


let estimated_value=

Math.round(
baseValue*(adjustment/100)
);



let report=

`
AI Business Valuation Report

Revenue:
${revenue}

Profit:
${profit}

Assets:
${assets}

Risk Score:
${risk_score}

Estimated Business Value:
${estimated_value}

`;



const {data,error}=await db

.from("business_valuations")

.insert([{

business_id,

revenue,

profit,

assets,

risk_score,

estimated_value,

ai_report:report

}])

.select();



return res.json({

success:!error,

estimated_value,

report,

data,

error

});


}



if(req.method==="GET"){


const business_id=req.query.business_id;


const {data,error}=await db

.from("business_valuations")

.select("*")

.eq("business_id",business_id);



return res.json({

success:true,

valuations:data||[],

error

});


}


res.status(405).json({

error:"Method not allowed"

});


};
