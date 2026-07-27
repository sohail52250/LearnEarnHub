const db=require("../database");

module.exports=async(req,res)=>{

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

};
