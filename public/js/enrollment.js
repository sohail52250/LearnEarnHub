(function(global){

    "use strict";

    async function enrollCourse(course_id,user_id){

        if(!course_id){
            throw new Error("course_id is required");
        }

        if(!user_id){
            const current =
                global.supabaseClient &&
                global.supabaseClient.auth
                    ? await global.supabaseClient.auth.getUser()
                    : null;

            user_id =
                current &&
                current.data &&
                current.data.user
                    ? current.data.user.id
                    : null;
        }

        if(!user_id){
            alert("Please login first");
            return;
        }

        try{

            const result =
                await global.LEHLearning.enrollCourse(
                    course_id,
                    user_id
                );

            alert(
                result &&
                (result.course_id || result.success || result.message)
                    ? "Course enrolled successfully."
                    : "Enrollment failed."
            );

            location.reload();

        }catch(error){

            console.error(
                "LearnEarnHub enrollment error:",
                error
            );

            alert(
                error.message ||
                "Enrollment failed."
            );
        }
    }

    global.enrollCourse = enrollCourse;

})(window);
