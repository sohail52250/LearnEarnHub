(function(global){
"use strict";

var COURSE_KEY="leh_active_course_id";
var LESSON_KEY="leh_active_lesson_id";

function params(){
    return new URLSearchParams(window.location.search);
}

function courseId(){
    var p=params();
    return p.get("course_id") || p.get("id") || localStorage.getItem(COURSE_KEY) || "";
}

function lessonId(){
    var p=params();
    return p.get("lesson_id") || localStorage.getItem(LESSON_KEY) || "1";
}

function remember(){
    var c=courseId();
    var l=lessonId();

    if(c){
        localStorage.setItem(COURSE_KEY,c);
    }

    if(l){
        localStorage.setItem(LESSON_KEY,l);
    }

    return {
        course_id:c,
        lesson_id:l
    };
}

async function getSession(){
    var clients=[
        global.supabaseClient,
        global.supabase
    ];

    for(var i=0;i<clients.length;i++){
        var client=clients[i];

        if(client &&
           client.auth &&
           typeof client.auth.getSession==="function"){

            try{
                var result=await client.auth.getSession();

                if(result &&
                   result.data &&
                   result.data.session){

                    return result.data.session;
                }
            }catch(error){}
        }
    }

    return null;
}

async function requireLearner(){
    var session=await getSession();

    if(!session || !session.user){
        var target=window.location.pathname+
                   window.location.search;

        window.location.href=
            "/auth/sign-in.html?redirect="+
            encodeURIComponent(target);

        return null;
    }

    return session;
}

async function enroll(){
    var session=await requireLearner();

    if(!session){
        return null;
    }

    var context=remember();

    if(!context.course_id){
        throw new Error("No course selected.");
    }

    if(!global.LEH_LEARNING_API ||
       typeof global.LEH_LEARNING_API.enrollCourse!=="function"){

        throw new Error(
            "Learning enrollment API is unavailable."
        );
    }

    try{
        return await global.LEH_LEARNING_API.enrollCourse(
            context.course_id,
            session.user.id
        );
    }catch(error){

        if(error &&
           error.message &&
           /already|exist|enrolled/i.test(error.message)){

            return {
                success:true,
                already_enrolled:true
            };
        }

        throw error;
    }
}

async function completeLesson(){
    var session=await requireLearner();

    if(!session){
        return null;
    }

    var context=remember();

    if(!context.course_id || !context.lesson_id){
        throw new Error(
            "Course or lesson context is missing."
        );
    }

    if(!global.LEH_LEARNING_API ||
       typeof global.LEH_LEARNING_API.completeLesson!=="function"){

        throw new Error(
            "Lesson completion API is unavailable."
        );
    }

    return global.LEH_LEARNING_API.completeLesson(
        context.course_id,
        context.lesson_id,
        session.user.id
    );
}

async function progress(){
    var session=await requireLearner();

    if(!session){
        return null;
    }

    var context=remember();

    if(!global.LEH_LEARNING_API ||
       typeof global.LEH_LEARNING_API.courseProgress!=="function"){

        throw new Error(
            "Course progress API is unavailable."
        );
    }

    return global.LEH_LEARNING_API.courseProgress(
        session.user.id,
        context.course_id
    );
}

function go(path,includeLesson){
    var context=remember();
    var query=[];

    if(context.course_id){
        query.push(
            "course_id="+encodeURIComponent(context.course_id)
        );
    }

    if(includeLesson && context.lesson_id){
        query.push(
            "lesson_id="+encodeURIComponent(context.lesson_id)
        );
    }

    window.location.href=
        path+
        (query.length ? "?"+query.join("&") : "");
}

global.LEHAuthenticatedLearning={
    getSession:getSession,
    requireLearner:requireLearner,
    remember:remember,
    enroll:enroll,
    completeLesson:completeLesson,
    progress:progress,
    courseId:courseId,
    lessonId:lessonId,
    go:go
};

})(window);
