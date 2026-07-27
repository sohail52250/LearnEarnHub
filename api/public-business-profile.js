const db=require("../database");

module.exports=async(req,res)=>{

const user_id=req.query.user_id;


const profile=await db
.from("business_profiles_complete")
.select("*")
.eq("user_id",user_id)
.single();


const opportunities=await db
.from("business_opportunities")
.select("*")
.eq("user_id",user_id);


const reviews=await db
.from("business_reviews")
.select("*")
.eq("business_id",user_id);


res.json({

success:true,

profile:profile.data,

opportunities:opportunities.data || [],

reviews:reviews.data || []

});


};
