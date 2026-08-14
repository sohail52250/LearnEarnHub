(function () {
  "use strict";

  function setActiveNavigation() {
    var path = window.location.pathname.replace(/\/+$/, "") || "/";

    document.querySelectorAll("[data-leh-nav]").forEach(function (link) {
      var href = link.getAttribute("href");
      if (!href) return;

      var normalized = href.replace(/\/+$/, "") || "/";

      if (normalized === path) {
        link.setAttribute("aria-current", "page");
      } else {
        link.removeAttribute("aria-current");
      }
    });
  }

  document.addEventListener("DOMContentLoaded", setActiveNavigation);
})();
