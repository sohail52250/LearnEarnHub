const service=require("../services/admin-lesson-service");


module.exports=async function(req,res){

try{


if(req.body.action==="create"){

return res.json(
await service.createLesson(
req.body.lesson
)
);

}



if(req.body.action==="update"){

return res.json(
await service.updateLesson(
req.body.id,
req.body.lesson
)
);

}



if(req.body.action==="delete"){

return res.json(
await service.deleteLesson(
req.body.id
)
);

}



if(req.query.course_id){

return res.json(
await service.listLessons(
req.query.course_id
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

