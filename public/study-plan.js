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

    try{
        await ensureLearningApi();

        const client = window.supabase && typeof window.supabase.createClient === "function"
            ? window.supabase.createClient(SUPABASE_URL,SUPABASE_ANON_KEY)
            : null;

        let progress = [];

        if(client){
            const {data:userData}=await client.auth.getUser();
            const user = userData && userData.user ? userData.user : null;

            if(user){
                const {data:progressData}=await client
                    .from("lesson_progress")
                    .select("*")
                    .eq("user_id",user.id);
                progress = progressData || [];
            }
        }

        const response = await window.LEH_LEARNING_API.getCourses();
        const courses = Array.isArray(response)
            ? response
            : (response && Array.isArray(response.courses) ? response.courses : []);

        if(!courses.length){
            throw new Error("No courses were returned by the canonical learning API.");
        }

        /*
         * Step 24E canonical recommendation:
         * Prefer the existing Computer Fundamentals root beginner course.
         * The ID is taken only from /api/courses; it is never invented.
         */
        const recommended = courses.find(function(course){
            const title=String(course.title || course.name || course.course_title || "").trim().toLowerCase();
            const category=String(course.category || course.type || "").trim().toLowerCase();
            return title === "computer fundamentals" ||
                (title.indexOf("computer") !== -1 && category.indexOf("root beginner") !== -1);
        }) || courses.find(function(course){
            const level=String(course.level || course.difficulty || "").trim().toLowerCase();
            return level === "beginner";
        });

        if(!recommended){
            throw new Error("No beginner course was returned by the canonical learning API.");
        }

        const courseId = recommended.id || recommended.course_id;
        if(courseId == null || courseId === ""){
            throw new Error("The recommended course has no usable ID.");
        }

        const title = recommended.title || recommended.name || recommended.course_title || "Recommended Course";
        const description = recommended.description || recommended.summary ||
            "Build practical skills through focused lessons and guided learning.";

        let lessons=[];
        try{
            const lessonResponse = await fetch("/api/courses/lessons/" + encodeURIComponent(String(courseId)));
            if(lessonResponse.ok){
                const lessonData=await lessonResponse.json();
                lessons=Array.isArray(lessonData) ? lessonData : [];
            }
        }catch(_){
            lessons=[];
        }

        lessons.sort(function(a,b){
            return Number(a.lesson_order || 0)-Number(b.lesson_order || 0);
        });

        const firstLesson=lessons[0] || null;
        const lessonId=firstLesson && (firstLesson.id || firstLesson.lesson_id || firstLesson.lesson_order);
        const firstLessonTitle=firstLesson && firstLesson.title ? firstLesson.title : "First Lesson";

        const completedCourseIds = progress.map(function(item){
            return String(item.course_id == null ? "" : item.course_id);
        });

        const completedSlugs = progress.map(function(item){
            return String(item.course_slug == null ? "" : item.course_slug).toLowerCase();
        });

        const recommendedCompleted =
            completedCourseIds.indexOf(String(courseId)) !== -1 ||
            completedSlugs.indexOf("computer-basics") !== -1 ||
            completedSlugs.indexOf("computer-fundamentals") !== -1;

        const roadmap=[
            {
                title:title,
                courseId:String(courseId),
                lessonId:lessonId == null ? "" : String(lessonId),
                done:recommendedCompleted,
                recommended:true
            }
        ];

        const legacyRoadmap=[
            {slug:"internet-browsing",title:"Internet Skills"},
            {slug:"email-basics",title:"Email Skills"},
            {slug:"word-basics",title:"Microsoft Word"},
            {slug:"excel-basics",title:"Microsoft Excel"},
            {slug:"freelancing-basics",title:"Freelancing Basics"},
            {slug:"digital-marketing",title:"Digital Marketing"}
        ];

        legacyRoadmap.forEach(function(item){
            roadmap.push({
                title:item.title,
                courseId:"",
                lessonId:"",
                done:completedSlugs.indexOf(item.slug) !== -1,
                recommended:false
            });
        });

        box.innerHTML=roadmap.map(function(item){
            const marker=item.done ? "✓" : (item.recommended ? "→" : "🔒");
            return "<p>" + marker + " " +
                (item.recommended ? "<strong>Recommended: </strong>" : "") +
                escapeHtml(item.title) + "</p>";
        }).join("");

        let firstLessonHref="/learning/course.html?id=" + encodeURIComponent(String(courseId));
        if(lessonId != null && lessonId !== ""){
            firstLessonHref += "&lesson_id=" + encodeURIComponent(String(lessonId));
        }

        if(recommendedCompleted){
            nextBox.innerHTML=
                "<h3>✓ Recommended course completed</h3>"+
                "<p>" + escapeHtml(title) + " is already in your completed learning path.</p>"+
                "<a class=\"btn btn-primary\" href=\"/learning/courses.html\">Browse Courses</a>";
            return;
        }

        nextBox.innerHTML=
            "<h3>Recommended Course: " + escapeHtml(title) + "</h3>"+
            "<p>" + escapeHtml(description) + "</p>"+
            (firstLesson ? "<p><strong>First lesson:</strong> " + escapeHtml(firstLessonTitle) + "</p>" : "")+
            "<a class=\"btn btn-primary\" href=\"" + firstLessonHref + "\">Start Recommended Course</a>";

    }catch(error){
        console.error("LearnEarnHub study plan error:",error);
        box.innerHTML="<p>Unable to load your study plan right now. Please try again later.</p>";
        nextBox.innerHTML="<p>Recommended course information is temporarily unavailable.</p>";
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
