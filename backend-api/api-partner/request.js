
const {createClient}=require("@supabase/supabase-js");

require("dotenv").config();


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);


module.exports=async(req,res)=>{


if(req.method!=="POST")
return res.status(405).json({
error:"POST required"
});


try{


const {company_name,email,purpose}=req.body;


let result=await db
.from("api_join_requests")
.insert({

company_name,
email,
purpose,
status:"pending"

})
.select();


res.json({

success:true,

message:
"API partnership request submitted",

data:
result.data

});


}catch(e){

res.status(500).json({
error:e.message
});

}


};

