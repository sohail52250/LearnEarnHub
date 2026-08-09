
const auth=require("../../middleware/api-key-auth");


module.exports=[
auth,
(req,res)=>{

res.json({

success:true,

message:"LearnEarnHub API authentication active",

partner:req.apiPartner.partner_id

});

}

];

