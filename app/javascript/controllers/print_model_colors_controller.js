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
      pla: ["343434", "000000", "808080", "008000", "FF0000", "FFEA00", "0000FF" ],
      abs: ["343434", "000000", "808080", "008000", "FF0000", "FFEA00", "0000FF" ],
      pet: ["343434", "000000", "71797E"],
      nylon: ["EDEADE"],
      elastan: ["000000"]
    };
  }
}

