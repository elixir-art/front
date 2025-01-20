let Hooks = {};
Hooks.ThemeToggle = {
  mounted() {
    this.handleEvent("toggle_theme", () => {
      document.documentElement.classList.toggle("dark");
    });
  }
};
Hooks.Form = {
  mounted() {
    this.handleEvent("handle_step_animation", (step) => {
      const loader = document.getElementById(step.id);

      if (loader) {
        loader.classList.add("absolute", "w-full", "h-full", "bg-blue-500", "animate-step");
      }
    })
  }
}

export default Hooks;
