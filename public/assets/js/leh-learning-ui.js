(function (window, document) {
  "use strict";

  var API =
    window.leh_learning_api ||
    window.leh_api ||
    window.LEH_LEARNING_API ||
    window.LEH_API ||
    null;

  if (!API || typeof API.get !== "function") {
    return;
  }

  function query(name) {
    try {
      return new URLSearchParams(window.location.search).get(name) || "";
    } catch (e) {
      return "";
    }
  }

  function idOf(item) {
    if (!item) return "";
    return String(
      item.id ||
      item.course_id ||
      item.courseId ||
      item.course_id ||
      item.resource_id ||
      item.lesson_id ||
      item.lessonId ||
      item.uuid ||
      ""
    );
  }

  function titleOf(item) {
    if (!item) return "Untitled";
    return String(
      item.title ||
      item.name ||
      item.course_name ||
      item.resource_name ||
      item.lesson_name ||
      "Untitled"
    );
  }

  function descriptionOf(item) {
    if (!item) return "";
    return String(
      item.description ||
      item.summary ||
      item.body ||
      ""
    );
  }

  function unwrap(value) {
    if (!value) return value;

    if (value.data !== undefined) {
      return value.data;
    }

    if (value.result !== undefined) {
      return value.result;
    }

    return value;
  }

  function list(value) {
    value = unwrap(value);

    if (Array.isArray(value)) return value;
    if (value && Array.isArray(value.items)) return value.items;
    if (value && Array.isArray(value.courses)) return value.courses;
    if (value && Array.isArray(value.lessons)) return value.lessons;

    return [];
  }

  function escapeHtml(value) {
    return String(value == null ? "" : value).replace(
      /[&<>"']/g,
      function (char) {
        return {
          "&": "&amp;",
          "<": "&lt;",
          ">": "&gt;",
          '"': "&quot;",
          "'": "&#39;"
        }[char];
      }
    );
  }

  function root() {
    return (
      document.querySelector("[data-learning-root]") ||
      document.querySelector("main") ||
      document.body
    );
  }

  function status(message) {
    var element = document.getElementById("leh-learning-status");

    if (!element) {
      element = document.createElement("div");
      element.id = "leh-learning-status";
      element.setAttribute("role", "status");
      element.setAttribute("aria-live", "polite");

      root().prepend(element);
    }

    element.textContent = message;
  }

  async function get(path) {
    return API.get(path);
  }

  async function post(path, body) {
    if (typeof API.post !== "function") {
      throw new Error("Learning API POST method is unavailable.");
    }

    return API.post(path, body);
  }

  async function courses() {
    return list(await get("/courses"));
  }

  async function course(id) {
    return unwrap(
      await get("/courses/" + encodeURIComponent(id))
    );
  }

  async function lessons(id) {
    var paths = [
      "/courses/" + encodeURIComponent(id) + "/lessons",
      "/lessons?course_id=" + encodeURIComponent(id)
    ];

    for (var i = 0; i < paths.length; i++) {
      try {
        var result = list(await get(paths[i]));

        if (result.length) {
          return result;
        }
      } catch (e) {
        // Try the next compatible API route.
      }
    }

    return [];
  }

  async function enroll(id) {
    return post("/enrollment", {
      action: "enroll",
      course_id: id
    });
  }

  async function complete(courseId, lessonId) {
    return post("/progress/complete", {
      course_id: courseId,
      lesson_id: lessonId
    });
  }

  async function progress(id) {
    var paths = [
      "/progress?course_id=" + encodeURIComponent(id),
      "/courses/" + encodeURIComponent(id) + "/progress"
    ];

    for (var i = 0; i < paths.length; i++) {
      try {
        return unwrap(await get(paths[i]));
      } catch (e) {
        // Try next route.
      }
    }

    return {};
  }

  async function certificates() {
    return list(await get("/certificates"));
  }

  async function renderCourses() {
    try {
      var data = await courses();
      var target = root();

      target.innerHTML =
        data.length
          ? data.map(function (item) {
              var id = idOf(item);

              return (
                '<article class="card">' +
                  "<h3>" + escapeHtml(titleOf(item)) + "</h3>" +
                  "<p>" + escapeHtml(descriptionOf(item)) + "</p>" +
                  '<a class="card-link" href="/learning/course.html?course_id=' +
                    encodeURIComponent(id) +
                    '">View course</a>' +
                "</article>"
              );
            }).join("")
          : "<p>No courses are currently available.</p>";
    } catch (e) {
      status("Courses could not be loaded.");
    }
  }

  async function renderCourse() {
    var id =
      query("course_id") ||
      query("courseId") ||
      query("id");

    if (!id) {
      status("Select a course from the catalogue.");
      return;
    }

    try {
      var item = await course(id);
      var data = await lessons(id);
      var target = root();

      target.innerHTML =
        '<section class="card">' +
          '<span class="eyebrow">Course details</span>' +
          "<h1>" + escapeHtml(titleOf(item)) + "</h1>" +
          "<p>" + escapeHtml(descriptionOf(item)) + "</p>" +
          '<button id="leh-enroll" class="btn btn-primary" type="button">' +
            "Enroll / Start course" +
          "</button>" +
        "</section>" +

        '<section class="card">' +
          "<h2>Lessons</h2>" +
          (
            data.length
              ? data.map(function (lesson, index) {
                  var lessonId = idOf(lesson);

                  return (
                    '<p><a class="card-link" href="/learning/lesson.html?course_id=' +
                    encodeURIComponent(id) +
                    "&lesson_id=" +
                    encodeURIComponent(lessonId) +
                    '">' +
                    escapeHtml(
                      titleOf(lesson) ||
                      ("Lesson " + (index + 1))
                    ) +
                    "</a></p>"
                  );
                }).join("")
              : "<p>No lessons available.</p>"
          ) +
        "</section>";

      var enrollButton = document.getElementById("leh-enroll");

      if (enrollButton) {
        enrollButton.addEventListener("click", async function () {
          try {
            await enroll(id);
            status("Course enrolled successfully.");
          } catch (e) {
            status("Please sign in before enrolling.");
          }
        });
      }
    } catch (e) {
      status("Course details could not be loaded.");
    }
  }

  async function renderLesson() {
    var courseId =
      query("course_id") ||
      query("courseId") ||
      query("id");

    var lessonId =
      query("lesson_id") ||
      query("lessonId") ||
      query("lesson");

    if (!courseId || !lessonId) {
      status("Select a course and lesson.");
      return;
    }

    try {
      var data = await lessons(courseId);

      var item = data.find(function (entry) {
        return idOf(entry) === String(lessonId);
      });

      if (!item) {
        throw new Error("Lesson not found");
      }

      root().innerHTML =
        '<section class="card">' +
          "<h1>" + escapeHtml(titleOf(item)) + "</h1>" +
          '<div class="lesson-body">' +
            escapeHtml(descriptionOf(item)) +
          "</div>" +
          '<button id="leh-complete" class="btn btn-primary" type="button">' +
            "Mark lesson complete" +
          "</button>" +
        "</section>";

      var completeButton = document.getElementById("leh-complete");

      if (completeButton) {
        completeButton.addEventListener("click", async function () {
          try {
            await complete(courseId, lessonId);
            status("Lesson marked complete.");
          } catch (e) {
            status("Lesson completion could not be saved.");
          }
        });
      }
    } catch (e) {
      status("Lesson could not be loaded.");
    }
  }

  async function renderProgress() {
    var id =
      query("course_id") ||
      query("courseId") ||
      query("id");

    if (!id) {
      status("Select a course to view progress.");
      return;
    }

    try {
      var data = await progress(id);

      root().innerHTML =
        '<section class="card">' +
          "<h1>Learning progress</h1>" +
          "<pre>" +
            escapeHtml(JSON.stringify(data, null, 2)) +
          "</pre>" +
        "</section>";
    } catch (e) {
      status("Progress could not be loaded.");
    }
  }

  async function renderCertificates() {
    try {
      var data = await certificates();

      root().innerHTML =
        data.length
          ? data.map(function (item) {
              return (
                '<article class="card">' +
                  "<h3>" + escapeHtml(titleOf(item)) + "</h3>" +
                  "<p>" + escapeHtml(descriptionOf(item)) + "</p>" +
                "</article>"
              );
            }).join("")
          : "<p>No certificates available.</p>";
    } catch (e) {
      status("Certificates could not be loaded.");
    }
  }

  window.lehLearning = {
    courses: courses,
    course: course,
    lessons: lessons,
    enroll: enroll,
    complete: complete,
    progress: progress,
    certificates: certificates,
    renderCourses: renderCourses,
    renderCourse: renderCourse,
    renderLesson: renderLesson,
    renderProgress: renderProgress,
    renderCertificates: renderCertificates
  };

  document.addEventListener("DOMContentLoaded", function () {
    var path = String(window.location.pathname || "").toLowerCase();

    if (path.endsWith("/courses.html")) {
      renderCourses();
    } else if (path.endsWith("/course.html")) {
      renderCourse();
    } else if (path.endsWith("/lesson.html")) {
      renderLesson();
    } else if (path.endsWith("/progress.html")) {
      renderProgress();
    } else if (path.endsWith("/certificate.html")) {
      renderCertificates();
    }
  });

})(window, document);