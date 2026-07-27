const db=require("../database");

module.exports=async(req,res)=>{


const companies=await db
.from("global_companies")
.select("*")
.order("created_at",{ascending:false});


const suppliers=await db
.from("supplier_marketplace")
.select("*")
.order("created_at",{ascending:false});


const opportunities=await db
.from("global_opportunities")
.select("*")
.order("created_at",{ascending:false});


res.json({

success:true,

companies:companies.data||[],

suppliers:suppliers.data||[],

opportunities:opportunities.data||[]

});


};
