const db = require("../database");

module.exports = async (req,res)=>{

if(req.method==="GET"){

const {data,error}=await db
.from("users")
.select("*");

return res.json({
data,error
});

}


if(req.method==="POST"){

const {name,email,phone}=req.body;

const {data,error}=await db
.from("users")
.insert([
{
name,
email,
phone
}
])
.select();

return res.json({
data,error
});

}

};
