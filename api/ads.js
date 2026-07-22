const db=require("../database");

module.exports=async(req,res)=>{


if(req.method==="GET"){

const {data,error}=await db
.from("ads")
.select("*")
.order("created_at",{ascending:false});

return res.json({
data,
error
});

}



if(req.method==="POST"){

const {
user_id,
title,
description,
category,
contact,
location
}=req.body;


const {data,error}=await db
.from("ads")
.insert([
{
user_id,
title,
description,
category,
contact,
location
}
])
.select();


return res.json({
success:!error,
data,
error
});

}


res.json({
message:"Use GET or POST"
});


};
