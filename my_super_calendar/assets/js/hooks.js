let Hooks = {};
Hooks.ThemeToggle = {
  mounted() {
    this.handleEvent("toggle_theme", () => {
      document.documentElement.classList.toggle("dark");
    });
  }
};

export default Hooks;