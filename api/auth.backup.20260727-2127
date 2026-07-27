const db = require("../database");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");


module.exports = async(req,res)=>{

if(req.method==="POST"){

const {action,name,email,password,phone}=req.body;


if(action==="register"){

const hash = await bcrypt.hash(password,10);


const {data,error}=await db
.from("users")
.insert([{
name,
email,
password:hash,
phone
}])
.select();


return res.json({
success:!error,
data,
error
});

}



if(action==="login"){

const {data,error}=await db
.from("users")
.select("*")
.eq("email",email)
.single();


if(error){
return res.json({
success:false,
message:"User not found"
});
}


const ok = await bcrypt.compare(
password,
data.password
);


if(!ok){
return res.json({
success:false,
message:"Wrong password"
});
}


const token = jwt.sign(
{id:data.id},
"learnEarnSecret"
);


delete data.password;

return res.json({
success:true,
token,
user:data
});


}

}

res.json({
message:"Use POST"
});

};
