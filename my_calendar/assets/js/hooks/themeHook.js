let ThemeHook = {
  mounted() {
    this.el.addEventListener("click", () => {
      document.documentElement.classList.toggle("dark");

      this.pushEvent("toggle_theme");
    });
  },
};

export default ThemeHook;
