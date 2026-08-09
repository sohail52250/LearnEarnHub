/* LearnEarnHub — canonical learner course-flow helper */
(function () {
  "use strict";

  const FLOW = {
    learn: "/learn.html",
    courses: "/courses.html",
    categories: "/course-categories.html",
    marketplace: "/course-marketplace.html",
    player: "/course-player.html",
    lesson: "/lesson.html",
    progress: "/course-progress.html",
    learningPath: "/learning-path.html",
    myCourses: "/my-courses.html",
    completion: "/completion.html",
    certificate: "/certificate.html",
    quiz: "/quiz.html",
    practice: "/practice.html",
    studyPlan: "/study-plan.html"
  };

  function params() {
    return new URLSearchParams(window.location.search);
  }

  function courseId() {
    const p = params();
    return (
      p.get("course_id") ||
      p.get("courseId") ||
      p.get("id") ||
      p.get("course") ||
      ""
    );
  }

  function withCourse(url) {
    const id = courseId();
    return id ? url + "?id=" + encodeURIComponent(id) : url;
  }

  window.LEH_COURSE_FLOW = FLOW;
  window.LEH_courseId = courseId;
  window.LEH_withCourse = withCourse;

  function addFlowBar() {
    if (document.querySelector("[data-leh-course-flow]")) {
      return;
    }

    const path = window.location.pathname;

    const coursePage =
      /\/(course-player|course-progress|lesson|completion|certificate|quiz|practice|my-courses|study-plan|learning-path|course-categories|course-marketplace|computer-fundamentals)\.html$/i.test(path);

    if (!coursePage) {
      return;
    }

    const bar = document.createElement("nav");

    bar.setAttribute("data-leh-course-flow", "true");
    bar.setAttribute("aria-label", "Course learning navigation");

    bar.style.cssText =
      "display:flex;" +
      "flex-wrap:wrap;" +
      "gap:8px;" +
      "padding:12px;" +
      "margin:16px 0;" +
      "border-radius:12px;" +
      "background:rgba(127,127,127,.08);" +
      "font-size:14px;" +
      "align-items:center;";

    const links = [
      ["📚 Learn", FLOW.learn],
      ["🎓 Courses", FLOW.courses],
      ["🗂 Categories", FLOW.categories],
      ["🛒 Marketplace", FLOW.marketplace],
      ["📖 My Courses", withCourse(FLOW.myCourses)],
      ["▶️ Continue", withCourse(FLOW.player)],
      ["📝 Lesson", withCourse(FLOW.lesson)],
      ["📊 Progress", withCourse(FLOW.progress)],
      ["🧠 Quiz", withCourse(FLOW.quiz)],
      ["🏆 Completion", withCourse(FLOW.completion)],
      ["🎓 Certificate", withCourse(FLOW.certificate)]
    ];

    links.forEach(function ([label, href]) {
      const a = document.createElement("a");

      a.href = href;
      a.textContent = label;

      a.style.cssText =
        "text-decoration:none;" +
        "padding:7px 10px;" +
        "border-radius:8px;" +
        "border:1px solid rgba(127,127,127,.25);";

      bar.appendChild(a);
    });

    const main =
      document.querySelector("main") ||
      document.querySelector(".container") ||
      document.body.firstElementChild ||
      document.body;

    if (main && main.parentNode) {
      main.parentNode.insertBefore(bar, main);
    }
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", addFlowBar);
  } else {
    addFlowBar();
  }
})();
