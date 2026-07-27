const db=require("../database");

module.exports=async(req,res)=>{

const search=req.query.search || "";
const category=req.query.category || "";
const city=req.query.city || "";


let query=db
.from("business_profiles_complete")
.select("*")
.eq("verification_status","verified");


if(search){

query=query.ilike(
"company_name",
"%"+search+"%"
);

}


if(category){

query=query.eq(
"category",
category
);

}


if(city){

query=query.eq(
"city",
city
);

}


const {data,error}=await query;


res.json({

success:!error,

businesses:data || [],

error

});


};
