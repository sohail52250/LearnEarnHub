const db = require("../database");

module.exports = async (req,res)=>{

if(req.method==="GET"){

const {data,error}=await db
.from("users")
.select(`
id,
name,
email,
phone,
language,
points,
created_at
`);

return res.json({
data,
error
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
.select(`
id,
name,
email,
phone,
language,
points,
created_at
`);

return res.json({
data,
error
});

}


return res.status(405).json({
error:"Method not allowed"
});

};
