
async function generateInstructorFeedback(course){


let feedback=[];

let score=100;


if(!course.description){

score-=20;

feedback.push(
"Add a detailed course description"
);

}


if(!course.lessons){

score-=30;

feedback.push(
"Add structured lessons"
);

}


if(!course.quiz){

score-=20;

feedback.push(
"Add assessment or quizzes"
);

}


if(!course.category){

score-=15;

feedback.push(
"Select correct skill category"
);

}


if(feedback.length===0){

feedback.push(
"Course quality looks good"
);

}



return {

quality_score:score,

feedback_type:
score>=80
?
"positive"
:
"improvement",


feedback_message:
feedback.join(". ")

};


}

