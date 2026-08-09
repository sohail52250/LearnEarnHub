/* LearnEarnHub shared lesson functions */

(function () {
  "use strict";

  window.completeLesson = window.completeLesson || function (lessonId) {
    try {
      const key = "leh_completed_lessons";
      const completed = JSON.parse(localStorage.getItem(key) || "[]");

      if (lessonId && !completed.includes(lessonId)) {
        completed.push(lessonId);
        localStorage.setItem(key, JSON.stringify(completed));
      }

      const status = document.getElementById("status");

      if (status) {
        status.textContent = "Lesson completed!";
      }

      return true;
    } catch (error) {
      console.error("LearnEarnHub lesson completion error:", error);
      return false;
    }
  };

  window.checkProgress = window.checkProgress || function (lessonId) {
    try {
      const key = "leh_completed_lessons";
      const completed = JSON.parse(localStorage.getItem(key) || "[]");
      const done = !!lessonId && completed.includes(lessonId);

      return done
        ? "Completed"
        : "Not completed yet";
    } catch (error) {
      console.error("LearnEarnHub lesson progress error:", error);
      return "Not completed yet";
    }
  };
})();
