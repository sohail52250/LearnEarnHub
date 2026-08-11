(function(global){

"use strict";

async function getCurrentUser(){

    if(!global.lehLearningApi){
        return null;
    }

    return await global.lehLearningApi.getCurrentUser();
}

async function completeLesson(course_id,lesson_id){

    if(!global.lehLearningApi){
        alert("Learning API is not loaded");
        return;
    }

    try{

        const result =
            await global.lehLearningApi.completeLesson(
                course_id,
                lesson_id
            );

        alert(
            result &&
            result.message
                ? result.message
                : "Lesson completed"
        );

        return result;

    }catch(error){

        console.error(
            "LearnEarnHub auth-progress error:",
            error
        );

        alert(
            error.message ||
            "Unable to complete lesson"
        );
    }
}

global.getCurrentUser = getCurrentUser;
global.completeLesson = completeLesson;

})(window);