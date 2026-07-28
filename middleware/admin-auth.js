
module.exports=function(req,res,next){

const role =
req.headers["x-user-role"];

if(role==="admin"){
return next();
}

return res.status(403).json({
error:"Admin access required"
});

};

