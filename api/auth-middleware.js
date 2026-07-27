const jwt=require("jsonwebtoken");


function requireAuth(req,res,next){

try{

const header=req.headers.authorization;


if(!header){

return res.status(401).json({
error:"Authentication required"
});

}


const token=header.replace("Bearer ","");


const decoded=jwt.verify(
token,
process.env.JWT_SECRET || "learn-earnhub-secret"
);


req.user=decoded;


next();


}catch(err){

return res.status(401).json({
error:"Invalid token"
});

}

}


function requireAdmin(req,res,next){

if(!req.user){

return res.status(401).json({
error:"Login required"
});

}


if(
req.user.role!=="admin" &&
req.user.is_admin!==true
){

return res.status(403).json({
error:"Admin access required"
});

}


next();

}


module.exports={
requireAuth,
requireAdmin
};
