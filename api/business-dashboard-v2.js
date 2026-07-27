const db=require("../database");

module.exports=async(req,res)=>{

const user_id=req.query.user_id;


const business=await db
.from("business_profiles")
.select("*")
.eq("user_id",user_id)
.single();


const opportunities=await db
.from("business_opportunities")
.select("*")
.eq("user_id",user_id);


const applications=await db
.from("opportunity_applications")
.select("*")
.eq("opportunity_id",
opportunities.data?.[0]?.id);


const products=await db
.from("business_products")
.select("*")
.eq("user_id",user_id);


res.json({

success:true,

business:business.data,

opportunities:opportunities.data || [],

applications:applications.data || [],

products:products.data || []

});


};
