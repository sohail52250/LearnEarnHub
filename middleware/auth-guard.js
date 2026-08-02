require("dotenv").config();


const adminEmails=
(process.env.ADMIN_EMAILS || "")
.split(",")
.map(x=>x.trim())
.filter(Boolean);



function adminGuard(req,res,next){


const email=
req.headers["x-user-email"];



if(!email){

return res.status(401).json({

error:"Authentication required"

});

}



if(!adminEmails.includes(email)){


return res.status(403).json({

error:"Admin access denied"

});

}



next();


}



module.exports={
adminGuard
};

