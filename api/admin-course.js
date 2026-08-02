const service=require("../services/admin-course-service");


module.exports=async function(req,res){

try{


if(req.body.action==="create"){

return res.json(
await service.createCourse(
req.body.course
)
);

}



if(req.body.action==="update"){

return res.json(
await service.updateCourse(
req.body.id,
req.body.course
)
);

}



if(req.body.action==="delete"){

return res.json(
await service.deleteCourse(
req.body.id
)
);

}



res.status(400).json({
error:"Invalid action"
});


}catch(e){

res.status(500).json({
error:e.message
});

}


};

