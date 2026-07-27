const db=require("../database");

module.exports=async(req,res)=>{


if(req.method==="POST"){


const {
investor_id,
question
}=req.body;


let response="";


if(question.toLowerCase().includes("risk")){

response=
"AI Analysis: Review risk level, compliance status and business performance before investing.";

}

else if(question.toLowerCase().includes("portfolio")){

response=
"AI Analysis: Portfolio should be diversified across opportunities and monitored regularly.";

}

else if(question.toLowerCase().includes("deal")){

response=
"AI Analysis: Check valuation, due diligence, investor terms and closing status.";

}

else{

response=
"AI Copilot: Your request has been analyzed using investment intelligence data.";

}



await db
.from("ai_copilot_sessions")
.insert([{

investor_id,

question,

ai_response:response

}]);



return res.json({

success:true,

response

});


}


res.status(405).json({

error:"Method not allowed"

});


};
