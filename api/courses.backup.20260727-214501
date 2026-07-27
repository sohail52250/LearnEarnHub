const db=require("../database");

module.exports=async(req,res)=>{

if(req.method==="GET"){

const {data,error}=await db
.from("courses")
.select("*")
.order("created_at",{ascending:false});

return res.json({
data,
error
});

}


if(req.method==="POST"){

const {
title_en,
title_ur,
description_en,
description_ur,
points
}=req.body;


const {data,error}=await db
.from("courses")
.insert([{
title_en,
title_ur,
description_en,
description_ur,
points:points || 10
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
