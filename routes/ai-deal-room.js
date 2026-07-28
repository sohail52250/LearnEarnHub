const express = require("express");
const router = express.Router();

const { supabase } = require("../database");
const requireAdmin = adminOnly;


function adminOnly(req,res,next){

    if(req.user && req.user.role === "admin"){
        next();
    }else{
        res.status(403).json({
            error:"Admin access required"
        });
    }

}


// Public request submission
router.post("/ai-deal-request", async(req,res)=>{

    const {
        name,
        email,
        company,
        purpose
    } = req.body;


    const {error}=await supabase
    .from("ai_deal_requests")
    .insert([
        {
            name,
            email,
            company,
            purpose,
            status:"pending"
        }
    ]);


    if(error){
        return res.status(500)
        .send(error.message);
    }


    res.send(
        "AI Deal Room request submitted"
    );

});



// Admin view requests
router.get("/admin/ai-deal-requests",
requireAdmin,
async(req,res)=>{


const {data,error}=await supabase
.from("ai_deal_requests")
.select("*")
.order("created_at",
{ascending:false});


if(error)
return res.status(500)
.json(error);


res.json(data);


});



// Admin approve access
router.post("/admin/ai-deal-approve/:id",
requireAdmin,
async(req,res)=>{


const {error}=await supabase
.from("ai_deal_requests")
.update({
status:"approved",
approved:true
})
.eq("id",req.params.id);



if(error)
return res.status(500)
.json(error);


res.json({
success:true,
message:"Access granted"
});


});



router.get("/ai-deal-test",(req,res)=>{
  res.json({
    success:true,
    message:"AI Deal Room API working"
  });
});




router.get("/ai-deal-access/:email", async(req,res)=>{
  const { data, error } = await supabase
    .from("ai_deal_access")
    .select("*")
    .eq("email", req.params.email)
    .eq("access_granted", true);

  if(error){
    return res.status(500).json(error);
  }

  res.json({
    access:data && data.length>0
  });
});


module.exports=router;
