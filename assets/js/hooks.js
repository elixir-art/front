let Hooks = {};
Hooks.ThemeToggle = {
  mounted() {
    this.handleEvent("toggle_theme", () => {
      document.documentElement.classList.toggle("dark");
    });
  }
};


const Validator = {
  getValidatedIncrementedPage(current_page) {
    if(current_page + 1 <= 4) {
      return current_page + 1;
    }
    return current_page
  },
  getValidatedDecrmentedPage(current_page) {
    if(current_page - 1 >= 1) {
      return current_page -1;
    }
    return current_page
  },

  validateForm(currentPage) {
    console.log(currentPage)
    switch(currentPage) {
      case 1:
        return this.validateFirstPage()
      case 2:
        return this.validateSecondPage()
      case 3:
        return this.validateThirdPage()
      default:
        return true
    }
  },

  validateFirstPage() {
    const inputList = Array.from(document.querySelectorAll("#email, #name, #phone, #company"));

    return inputList.some(input =>  input.value === '') ? this.triggerForm() : true
  },

  validateSecondPage() {
    const inputList = Array.from(
      document.querySelectorAll("#block-development, #block-web-design, #block-marketing, #other")
    );
    return inputList.some(input => input.checked)
  },
  
  validateThirdPage(){
    const inputList = Array.from(
      document.querySelectorAll("#small-amount, #medium-amount, #large-amount, #max-amount")
    );
    return inputList.some(input => input.checked)
  },

  triggerForm() {
    const triggerButton = document.getElementById('submit-btn');
    triggerButton.click()
    return false;
  }

}

const AnimationHelper = {
  getLoader(current_section) {
    return document.getElementById(`step-${current_section}`);
  },

  getSection(current_section) {
    return document.getElementById(`section-${current_section}`)
  },

  changeClassForLoader(loader, newClass) {
    if (loader) {
      loader.className = newClass
    }
    else {
      console.warn("Loader was not found")
    }
  },

  changeClassForSection(section, newClass) {
    if (section) {
      section.className = newClass;
    }
    else {
      console.warn("Section was not found")
    }
  },

  hidePreviousBlock(params) {
    if (params.current_section > 1) {
      const section = document.getElementById(`section-${params.current_section - 1}`)
      this.hideSection(section)
    }
  },

  hideNextBlock(params) {
    if (params.current_section < 4) {
      const section = document.getElementById(`section-${params.current_section + 1}`)
      this.hideSection(section)
    }
  },

  hideSection(section) {
    if (section) {
      section.className = "hidden";
    }
  }
}

const StepForwardAnimation = {
  handleStepForwardAnimation(params) {
    const loader = AnimationHelper.getLoader(params.current_section);
    const section = AnimationHelper.getSection(params.current_section);
    AnimationHelper.changeClassForLoader(loader, "absolute w-full h-full bg-blue-500 animate-step");
    AnimationHelper.changeClassForSection(section, "visible");
    AnimationHelper.hidePreviousBlock(params)
  }
};

const StepBackWardAnimation = {
  handleStepBackwardAnimation(params) {
    const loader = AnimationHelper.getLoader(params.current_section + 1);
    const section = AnimationHelper.getSection(params.current_section);
    AnimationHelper.changeClassForLoader(loader, "")
    AnimationHelper.changeClassForSection(section, "visible")
    AnimationHelper.hideNextBlock(params)
   
  }
}

Hooks.Form = {
  mounted() {
    this.handleEvent("handle_step_forward_animation", (params) => {
      params.current_section = Validator.getValidatedIncrementedPage(params.current_section)
      if(!Validator.validateForm(params.current_section - 1)) {
        console.log("BAD VALIDATION")
        return;
      }
      StepForwardAnimation.handleStepForwardAnimation(params);
      this.pushEvent("set_current_section", { current_section: params.current_section });
    });
    this.handleEvent("handle_step_backward_animation", (params) => {
      params.current_section = Validator.getValidatedDecrmentedPage(params.current_section)
      StepBackWardAnimation.handleStepBackwardAnimation(params);
      this.pushEvent("set_current_section", { current_section: params.current_section });
    });

    this.el.addEventListener("submit", (event) => {
      event.preventDefault(); 
      const formData = new FormData(this.el);
      formData.forEach((value, key) => {
        console.log(`Field ${key}: ${value}`);
      });
    });
  }
};

export default Hooks;
