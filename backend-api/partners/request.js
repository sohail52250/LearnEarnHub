const db=require("../../database");

module.exports=async(req,res)=>{

if(req.method!=="POST"){
return res.status(405).json({error:"POST required"});
}

try{

const {company_name,email,purpose}=req.body;

const result=await db
.from("api_join_requests")
.insert({
company_name,
email,
purpose
})
.select();

res.json({
success:true,
request:result.data
});

}catch(e){

res.status(500).json({
error:e.message
});

}

};
