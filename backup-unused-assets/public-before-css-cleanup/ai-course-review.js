
async function runAICourseReview(course){


let contentScore = 0;
let structureScore = 0;
let skillScore = 0;
let difficultyScore = 0;



if(course.title && course.description){

contentScore += 30;

}


if(course.lessons){

structureScore += 30;

}


if(course.category){

skillScore += 20;

}


if(course.level){

difficultyScore += 20;

}



let total =
contentScore +
structureScore +
skillScore +
difficultyScore;



let recommendation =
total >= 75
?
"approve"
:
"needs_improvement";



return {

content_score:contentScore,

structure_score:structureScore,

skill_score:skillScore,

difficulty_score:difficultyScore,

overall_score:total,

recommendation,

ai_notes:

`AI analysis completed.
Score: ${total}/100.
Recommendation: ${recommendation}`

};


}


