let Hooks = {};
Hooks.ThemeToggle = {
  mounted() {
    this.handleEvent("toggle_theme", () => {
      document.documentElement.classList.toggle("dark");
    });
  }
};

const AnimationHelper = {
  hidePreviousBlock(params) {
    if (params.current_section_id > 1) {
      const section = document.getElementById(`section-${params.current_section_id - 1}`)
      this.hideSection(section)
    }
  },
  hideNextBlock(params) {
    if (params.current_section_id < 4) {
      const section = document.getElementById(`section-${params.current_section_id + 1}`)
      this.hideSection(section)
    }
  },
  hideSection(section) {
    if (section) {
      section.className = "hidden";
    }
  },
  getLoader(current_section_id) {
    return document.getElementById(`step-${current_section_id}`);
  },
  getSection(current_section_id) {
    return document.getElementById(`section-${current_section_id}`)
  }
}

const StepForwardAnimation = {
  handleStepForwardAnimation(params) {
    const loader = AnimationHelper.getLoader(params.current_section_id);
    const section = AnimationHelper.getSection(params.current_section_id);

    if (loader && section) {
      loader.className = "absolute w-full h-full bg-blue-500 animate-step";
      section.className = "visible";
      AnimationHelper.hidePreviousBlock(params)
    } else {
      console.warn("Loader or section not found for step:", params);
    }
  }
};

const StepBackWardAnimation = {
  handleStepBackwardAnimation(params) {
    const loader = AnimationHelper.getLoader(params.current_section_id + 1);
    const section = AnimationHelper.getSection(params.current_section_id);
    if (loader && section) {
      loader.className = "";
      section.className = "visible";
      AnimationHelper.hideNextBlock(params)
    } else {
      console.warn("Loader or section not found for step:", params);
    }
  }
}

Hooks.Form = {
  mounted() {
    this.handleEvent("handle_step_forward_animation", (params) => {
      StepForwardAnimation.handleStepForwardAnimation(params);
    });
    this.handleEvent("handle_step_backward_animation", (params) => {
      StepBackWardAnimation.handleStepBackwardAnimation(params);
    });
  }
};

export default Hooks;
