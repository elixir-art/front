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

  getLi(current_section) {
    return document.getElementById(`li-${current_section}`)
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

  changeClassForLi(li, newClass) {
    if(li) {
      li.className = newClass
    }
    else {
      console.warn("Li was not found")
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
  },

  changeButtonsVisibility(current_page) {
    const prevBtn = document.getElementById("prev-btn");
    const nextBtn = document.getElementById("next-btn");
    if(current_page == 1) {
      this.hide_button(prevBtn)
      return;
    }
    else{
      this.show_button(prevBtn)
    }
    if(current_page == 4) {
      this.hide_button(nextBtn)
      return;
    }
    else{
      this.show_button(nextBtn)
    }
  },

  hide_button(button) {
    if (button) {
      if (button.classList.contains("visible")) {
        button.classList.remove("visible");
        button.classList.add("hidden");
      }
    }
  },

  show_button(button) {
    if (button) {
      if (button.classList.contains("hidden")) {
        button.classList.remove("hidden");
        button.classList.add("visible");
      }
    }
  }
}

const StepForwardAnimation = {
  handleStepForwardAnimation(params) {
    AnimationHelper.changeButtonsVisibility(params.current_section)
    const loader = AnimationHelper.getLoader(params.current_section);
    const section = AnimationHelper.getSection(params.current_section);
    const li = AnimationHelper.getLi(params.current_section - 1);
    AnimationHelper.changeClassForLoader(loader, "absolute w-full h-full bg-blue-500 animate-step");
    AnimationHelper.changeClassForSection(section, "visible");
    AnimationHelper.changeClassForLi(li, "flex items-center justify-center text-gray-200 w-[30px] h-[30px] bg-blue-600 rounded-full text-lg")
    AnimationHelper.hidePreviousBlock(params)
  }
};

const StepBackWardAnimation = {
  handleStepBackwardAnimation(params) {
    AnimationHelper.changeButtonsVisibility(params.current_section)
    const loader = AnimationHelper.getLoader(params.current_section + 1);
    const section = AnimationHelper.getSection(params.current_section);
    const li = AnimationHelper.getLi(params.current_section);
    AnimationHelper.changeClassForLoader(loader, "")
    AnimationHelper.changeClassForSection(section, "visible")
    AnimationHelper.changeClassForLi(li, "flex items-center justify-center text-gray-500 w-[30px] h-[30px] bg-gray-100 rounded-full text-lg")
    AnimationHelper.hideNextBlock(params)
   
  }
}

Hooks.Form = {
  mounted() {
    this.handleEvent("handle_step_forward_animation", (params) => {
      params.current_section = Validator.getValidatedIncrementedPage(params.current_section)
      if(!Validator.validateForm(params.current_section - 1)) {
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

      let formResult = ""
      const formData = new FormData(this.el);
      formData.forEach((value, key) => {
        formResult = formResult.concat(`Field ${key}: ${value}\n`)
      });

      alert(formResult)
    });
  }
};

Hooks.CheckBoxOutline = {
  mounted() {
    this.el.querySelector('input').addEventListener('change', (event) => {
      const container = this.el;

      if (event.target.checked) {
        container.classList.add('border-2', 'border-blue-800'); // Add outline when checked
      } else {
        container.classList.remove('border-2', 'border-blue-800'); // Remove outline when unchecked
      }
    });
  }
};



Hooks.RadioBoxOutline = {
  mounted() {
      this.el.querySelector('input').addEventListener('change', (event) => {

      const allContainers = document.querySelectorAll('.radio-container');
      allContainers.forEach((container) =>
        container.classList.remove('border-blue-800', 'border-2')
      );

      this.el.classList.add('border-blue-800', 'border-2');
    });
  },
};

export default Hooks;
