const {requireAuth,requireAdmin}=require("./auth-middleware");
const db=require("../database");



module.exports=async(req,res)=>{

try{

await new Promise((resolve,reject)=>{

requireAuth(req,res,()=>{

requireAdmin(req,res,()=>{

resolve();

});

});

});




if(!req.user){

return res.status(401).json({
error:"Login required"
});

}


if(req.user.role!=="admin"){

return res.status(403).json({
error:"Admin access required"
});

}


const {
action,
certificate_code,
reason
}=req.body;



if(!certificate_code){

return res.status(400).json({
error:"Certificate code required"
});

}



if(action==="approve"){


const {data,error}=await db
.from("certificates")
.update({

status:"approved",

approved_by:req.user.id,

approved_at:new Date().toISOString()

})
.eq(
"certificate_code",
certificate_code
)
.select();


return res.json({

success:!error,

certificate:data,

error

});


}



if(action==="revoke"){


const {data,error}=await db
.from("certificates")
.update({

status:"revoked",

revoked_reason:
reason || "No reason provided",

revoked_by:req.user.id,

revoked_at:new Date().toISOString()

})
.eq(
"certificate_code",
certificate_code
)
.select();



return res.json({

success:!error,

certificate:data,

error

});


}



res.status(400).json({

error:"Invalid action"

});


};
];
