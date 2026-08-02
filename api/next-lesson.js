const service=require("../services/next-lesson-service");


module.exports=async function(req,res){

try{


if(req.query.action==="next"){

return res.json(
await service.getNextLesson(
req.query.course_id,
req.query.lesson_order
)
);

}



if(req.query.action==="previous"){

return res.json(
await service.getPreviousLesson(
req.query.course_id,
req.query.lesson_order
)
);

}



if(req.query.action==="completion"){

return res.json(
await service.checkCompletion(
req.query.user_id,
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

