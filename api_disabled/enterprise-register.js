const db=require("../database");

module.exports=async(req,res)=>{


if(req.method==="POST"){


const {
user_id,
company_name,
industry,
description,
website,
email,
phone,
city,
country,
employees
}=req.body;


const {data,error}=await db
.from("enterprises")
.insert([{

user_id,
company_name,
industry,
description,
website,
email,
phone,
city,
country,
employees

}])
.select();


return res.json({

success:!error,

data,

error

});


}


res.status(405).json({
error:"Method not allowed"
});


};
