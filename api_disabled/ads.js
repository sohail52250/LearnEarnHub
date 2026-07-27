const db=require("../database");

module.exports=async(req,res)=>{

if(req.method==="GET"){

const {data,error}=await db
.from("ads")
.select("*")
.order("created_at",{ascending:false});

return res.json({data,error});

}


if(req.method==="POST"){

const {
user_id,
title,
title_ur,
description,
description_ur,
category,
contact,
location
}=req.body;


const {data,error}=await db
.from("ads")
.insert([
{
user_id,
title_en:title,
title_ur:title_ur || "",
description_en:description,
description_ur:description_ur || "",
category,
contact,
location,
approved:false
}
])
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
