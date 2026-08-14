async function ensureLearningApi(){
    if(window.LEH_LEARNING_API && typeof window.LEH_LEARNING_API.getCourses === "function"){
        return;
    }

    await new Promise(function(resolve,reject){
        const script=document.createElement("script");
        script.src="/assets/js/leh-learning-api.js";
        script.onload=resolve;
        script.onerror=function(){ reject(new Error("Unable to load the canonical learning API.")); };
        document.head.appendChild(script);
    });
}

async function loadStudyPlan(){
    const box=document.getElementById("study-plan");
    const nextBox=document.getElementById("next-step");

    if(!box || !nextBox){
        return;
    }

    try{
        await ensureLearningApi();

        const response=await window.LEH_LEARNING_API.getCourses();
        const courses=Array.isArray(response)
            ? response
            : (response && Array.isArray(response.courses) ? response.courses : []);

        if(!courses.length){
            throw new Error("No courses were returned by the canonical learning API.");
        }

        /*
         * Canonical recommendation:
         * select the existing Computer Basics course returned by /api/courses.
         * The course ID is never invented or hard-coded.
         */
        const recommended=courses.find(function(course){
            const title=String(
                course.title ||
                course.title_en ||
                course.name ||
                course.course_title ||
                ""
            ).trim().toLowerCase();

            return title === "computer basics";
        });

        if(!recommended){
            throw new Error("Canonical Computer Basics course was not returned by the learning API.");
        }

        const courseId=recommended.id || recommended.course_id;
        if(courseId == null || courseId === ""){
            throw new Error("The recommended course has no usable ID.");
        }

        const title=recommended.title || recommended.title_en || recommended.name || recommended.course_title || "Computer Basics";
        const description=recommended.description || recommended.summary ||
            "Build practical computer skills through focused lessons and guided learning.";

        let lessons=[];
        try{
            const lessonResponse=await fetch(
                "/api/courses/lessons/" + encodeURIComponent(String(courseId))
            );

            if(lessonResponse.ok){
                const lessonData=await lessonResponse.json();
                lessons=Array.isArray(lessonData)
                    ? lessonData
                    : (lessonData && Array.isArray(lessonData.lessons) ? lessonData.lessons : []);
            }
        }catch(_){
            lessons=[];
        }

        lessons.sort(function(a,b){
            return Number(a.lesson_order || a.order || 0)-Number(b.lesson_order || b.order || 0);
        });

        const firstLesson=lessons[0] || null;
        const lessonId=firstLesson && (
            firstLesson.id ||
            firstLesson.lesson_id ||
            firstLesson.lesson_order
        );
        const firstLessonTitle=firstLesson && (
            firstLesson.title ||
            firstLesson.name ||
            firstLesson.lesson_title
        ) || "First Lesson";

        const firstLessonHref=
            "/learning/course.html?id=" + encodeURIComponent(String(courseId)) +
            (lessonId != null && lessonId !== ""
                ? "&lesson_id=" + encodeURIComponent(String(lessonId))
                : "");

        const roadmap=[
            {
                marker:"→",
                title:title,
                detail:"Recommended starting course",
                href:firstLessonHref
            },
            {
                marker:"2",
                title:"Complete the course lessons",
                detail:"Work through the lessons and practical learning material.",
                href:firstLessonHref
            },
            {
                marker:"3",
                title:"Track your progress",
                detail:"Review your learning activity and continue from where you stopped.",
                href:"/learning/progress.html"
            },
            {
                marker:"4",
                title:"Get certified",
                detail:"Complete eligible learning requirements and view your certificates.",
                href:"/learning/certificate.html"
            }
        ];

        box.innerHTML=roadmap.map(function(item){
            return "<p role=\"listitem\"><strong>" +
                escapeHtml(item.marker) + "</strong> " +
                "<a href=\"" + escapeHtml(item.href) + "\">" +
                escapeHtml(item.title) +
                "</a> — " +
                escapeHtml(item.detail) +
                "</p>";
        }).join("");

        nextBox.innerHTML=
            "<h3>Recommended Course: " + escapeHtml(title) + "</h3>" +
            "<p>" + escapeHtml(description) + "</p>" +
            (firstLesson
                ? "<p><strong>First lesson:</strong> " + escapeHtml(firstLessonTitle) + "</p>"
                : "<p>Start the course and choose your first lesson when it opens.</p>") +
            "<a class=\"btn btn-primary\" href=\"" + escapeHtml(firstLessonHref) + "\">Start Recommended Course</a>";

    }catch(error){
        console.error("LearnEarnHub study plan error:",error);
        box.innerHTML="<p>Unable to load your study plan right now. Please try again later.</p>";
        nextBox.innerHTML=
            "<p>Recommended course information is temporarily unavailable.</p>"+
            "<a class=\"btn\" href=\"/learning/courses.html\">Browse Courses</a>";
    }
}

function escapeHtml(value){
    return String(value == null ? "" : value)
        .replace(/&/g,"&amp;")
        .replace(/</g,"&lt;")
        .replace(/>/g,"&gt;")
        .replace(/\"/g,"&quot;")
        .replace(/'/g,"&#039;");
}

document.addEventListener("DOMContentLoaded",loadStudyPlan);
