(function () {
  if (window.__tripmeticNavBound) return;
  window.__tripmeticNavBound = true;

  function setNavOpen(open) {
    document.documentElement.classList.toggle("nav-open", open);
    var btn = document.querySelector("[data-nav-toggle]");
    if (!btn) return;
    btn.setAttribute("aria-expanded", open ? "true" : "false");
    btn.setAttribute("aria-label", open ? "Close menu" : "Open menu");
  }

  document.addEventListener("click", function (e) {
    var toggle = e.target.closest("[data-nav-toggle]");
    if (toggle) {
      setNavOpen(!document.documentElement.classList.contains("nav-open"));
      return;
    }
    if (e.target.closest(".nav-links a")) {
      setNavOpen(false);
    }
  });

  window.addEventListener("resize", function () {
    if (window.innerWidth > 768) setNavOpen(false);
  });
})();
