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
  },
  changeClassForLoader(loader, newClass) {
    if(loader) {
      loader.className = newClass
    }
    else {
      console.warn("Loader was not found")
    }
  },
  changeClassForSection(section, newClass) {
    if(section) {
      section.className = newClass;
    }
    else{
      console.warn("Section was not found")
    }
  }
}

const StepForwardAnimation = {
  handleStepForwardAnimation(params) {
    const loader = AnimationHelper.getLoader(params.current_section_id);
    const section = AnimationHelper.getSection(params.current_section_id);
    AnimationHelper.changeClassForLoader(loader,"absolute w-full h-full bg-blue-500 animate-step");
    AnimationHelper.changeClassForSection(section, "visible");
    AnimationHelper.hidePreviousBlock(params)
    
  }
};

const StepBackWardAnimation = {
  handleStepBackwardAnimation(params) {
    const loader = AnimationHelper.getLoader(params.current_section_id + 1);
    const section = AnimationHelper.getSection(params.current_section_id);
    AnimationHelper.changeClassForLoader(loader, "")
    AnimationHelper.changeClassForSection(section, "visible")
    AnimationHelper.hideNextBlock(params)
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
