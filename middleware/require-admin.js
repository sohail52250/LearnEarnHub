const { supabase } = require("../database");

module.exports = async function(req,res,next){

try{

const token =
req.headers.authorization?.replace("Bearer ","");


if(!token){

return res.status(401).json({
error:"Login required"
});

}


const {data:userData,error} =
await supabase.auth.getUser(token);


if(error || !userData.user){

return res.status(401).json({
error:"Invalid session"
});

}


const {data:user,error:userError} =
await supabase
.from("users")
.select("role")
.eq("id",userData.user.id)
.single();


if(userError || !user || user.role!=="admin"){

return res.status(403).json({
error:"Admin access required"
});

}


req.user=userData.user;
next();


}catch(e){

res.status(500).json({
error:e.message
});

}

};
