(function () {
  const STORAGE_KEY = "theme";

  function applyTheme(theme) {
    if (!theme) {
      document.documentElement.removeAttribute("data-theme");
      return;
    }
    document.documentElement.setAttribute("data-theme", theme);
  }

  function currentTheme() {
    return localStorage.getItem(STORAGE_KEY);
  }

  function nextTheme(theme) {
    return theme === "dark" ? "light" : "dark";
  }

  window.toggleTheme = function toggleTheme() {
    const current = currentTheme() || (window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light");
    const next = nextTheme(current);
    localStorage.setItem(STORAGE_KEY, next);
    applyTheme(next);
    updateLabel();
  };

  function updateLabel() {
    const label = document.querySelector(".theme-toggle-label");
    if (!label) return;
    const theme = currentTheme() || (window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light");
    label.textContent = theme === "dark" ? "☀️" : "🌙";
  }

  document.addEventListener("DOMContentLoaded", function () {
    applyTheme(currentTheme());
    updateLabel();

    const button = document.getElementById("theme-toggle");
    if (button) {
      button.addEventListener("click", function () {
        window.toggleTheme();
      });
    }
  });
})();
