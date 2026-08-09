require("dotenv").config();


const ADMIN_EMAILS = (

process.env.ADMIN_EMAILS || ""

)
.split(",")
.map(x=>x.trim())
.filter(Boolean);



function adminAuth(req,res,next){


const email =
req.headers["x-user-email"];



if(!email){

return res.status(401).json({

error:"Admin login required"

});

}



if(!ADMIN_EMAILS.includes(email)){


return res.status(403).json({

error:"Access denied"

});

}



next();


}



module.exports=adminAuth;

