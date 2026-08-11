/*
 * LearnEarnHub canonical learning API bridge.
 * Safe migration layer.
 *
 * Provides the stable frontend learning API while preserving
 * existing backend APIs and legacy learning implementations.
 */

(function(global){

    "use strict";

    const client =
        global.LEHApi ||
        global.lehApi ||
        global.LEH_API_CLIENT ||
        null;

    function jsonHeaders(){
        return {
            "Content-Type":"application/json"
        };
    }

    async function post(path, body){
        const response = await fetch(
            path,
            {
                method:"POST",
                headers:jsonHeaders(),
                body:JSON.stringify(body || {})
            }
        );

        let data = null;

        try{
            data = await response.json();
        }catch(_){
            data = {};
        }

        if(!response.ok){
            const message =
                data &&
                (data.error || data.message);

            throw new Error(
                message ||
                ("Learning API request failed: " + response.status)
            );
        }

        return data;
    }

    async function get(path){
        const response = await fetch(path);

        let data = null;

        try{
            data = await response.json();
        }catch(_){
            data = {};
        }

        if(!response.ok){
            const message =
                data &&
                (data.error || data.message);

            throw new Error(
                message ||
                ("Learning API request failed: " + response.status)
            );
        }

        return data;
    }

    async function getCourses(){
        return get("/api/courses");
    }

    async function enrollCourse(course_id,user_id){
        return post(
            "/api/enrollment",
            {
                action:"enroll",
                course_id,
                user_id
            }
        );
    }

    async function completeLesson(course_id,lesson_id,user_id){
        return post(
            "/api/complete-lesson",
            {
                user_id,
                course_id,
                lesson_id
            }
        );
    }

    async function courseProgress(user_id,course_id){
        return get(
            "/api/course-progress?user_id=" +
            encodeURIComponent(user_id) +
            (course_id
                ? "&course_id=" + encodeURIComponent(course_id)
                : "")
        );
    }

    const learningApi = {
        getCourses,
        enrollCourse,
        completeLesson,
        courseProgress,
        apiClient: client
    };

    /*
     * Canonical API name.
     */
    global.LEHLearning = learningApi;

    /*
     * Compatibility alias used by existing learning pages.
     * This intentionally points to the same object.
     */
    global.LEH_LEARNING_API = learningApi;

})(window);
