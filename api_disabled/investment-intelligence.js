const db=require("../database");

module.exports=async(req,res)=>{


if(req.method==="GET"){


const insights=await db
.from("market_insights")
.select("*")
.order("created_at",{ascending:false});


const opportunities=await db
.from("opportunity_scores")
.select("*")
.order("score",{ascending:false});


return res.json({

success:true,

market_insights:insights.data||[],

top_opportunities:opportunities.data||[]

});

}


if(req.method==="POST"){


const {data,error}=await db

.from("market_insights")

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
