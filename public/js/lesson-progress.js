(function(global){

    "use strict";

    async function completeLesson(course_id,lesson_id){

        let user = null;

        if(
            global.supabaseClient &&
            global.supabaseClient.auth
        ){
            const result =
                await global.supabaseClient.auth.getUser();

            user =
                result &&
                result.data &&
                result.data.user
                    ? result.data.user
                    : null;
        }

        if(!user){
            alert("Please login first");
            return;
        }

        try{

            const result =
                await global.LEHLearning.completeLesson(
                    course_id,
                    lesson_id,
                    user.id
                );

            if(
                result &&
                (
                    result.success ||
                    result.message ||
                    result.data
                )
            ){
                alert("Lesson completed successfully.");
                location.reload();
                return;
            }

            alert(
                result &&
                result.error
                    ? result.error
                    : "Lesson completion failed."
            );

        }catch(error){

            console.error(
                "LearnEarnHub lesson completion error:",
                error
            );

            alert(
                error.message ||
                "Lesson completion failed."
            );
        }
    }

    global.completeLesson = completeLesson;

})(window);
