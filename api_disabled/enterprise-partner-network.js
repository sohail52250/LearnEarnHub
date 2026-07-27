const db=require("../database");

module.exports=async(req,res)=>{


if(req.method==="GET"){


const partners=await db
.from("enterprise_partners")
.select("*")
.order("created_at",{ascending:false});


const opportunities=await db
.from("b2b_opportunities")
.select("*")
.order("created_at",{ascending:false});


return res.json({

success:true,

partners:partners.data||[],

opportunities:opportunities.data||[]

});


}


if(req.method==="POST"){


const {data,error}=await db

.from("partnership_requests")

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
