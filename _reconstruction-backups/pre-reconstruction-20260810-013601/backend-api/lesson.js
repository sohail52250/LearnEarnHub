const service=require("../services/lesson-service");


module.exports=async function(req,res){

try{


if(req.query.course_id){

return res.json(
await service.getLesson(
req.query.course_id,
req.query.lesson_order
)
);

}



if(req.body.action==="complete"){

return res.json(
await service.completeLesson(
req.body.user_id,
req.body.course_id,
req.body.lesson_id
)
);

}


res.status(400).json({
error:"Invalid request"
});


}catch(e){

res.status(500).json({
error:e.message
});

}

};

