import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["color"]

  connect() {
    this.colorTarget.classList.add("hidden")
  }

  changeColor(e) {
    // Hide all color options
    this.colorTargets.forEach((colorTarget) => {
      colorTarget.classList.add("hidden");
    });
  
    const selector = e.target;
    const selectedMaterial = selector.options[selector.selectedIndex].value.toLowerCase();
    const colors = this.selectColorByMaterial[selectedMaterial];
    const replacedElement = document.getElementById("staticColors");
  
    // Remove previous color options
    while (replacedElement.firstChild) {
      replacedElement.firstChild.remove();
    }
  
    // Show the color options for the selected material
    colors.forEach((color) => {
      const newDiv = document.createElement("div");
      newDiv.className = "w-8 h-8 cursor-pointer rounded-full border";
      newDiv.dataset.action = "click->calculator#setColor";
      newDiv.dataset.calculatorColorParam = color;
      newDiv.style.backgroundColor = `#${color}`;
  
      replacedElement.appendChild(newDiv);
      replacedElement.classList.remove("hidden");
    });
  }


  // Dummy material colors
  get selectColorByMaterial() {
    return {
      pla: ["FFFFFF", "96E06C", "67ACEC", "5e36a2"],
      abs: ["96E06C", "67ACEC", "5e36a2"],
      pet: ["67ACEC", "5e36a2"],
      nylon: ["FFFFFF"],
      elastan: ["FFFFFF", "5e36a2"]
    };
  }
}

