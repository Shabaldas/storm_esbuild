import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["checkbox"];

  connect() {
    this.checkboxTargets.forEach((checkbox) => {
      checkbox.addEventListener("change", (event) => {
        this.toggleSelection(event.target);
      });
    });
  }

  toggleSelection(checkbox) {
    const isChecked = checkbox.checked;
    const parent = checkbox.closest("li");
    const children = parent.querySelectorAll("li input[type='checkbox']");

    children.forEach((child) => {
      child.checked = isChecked;
    });
  }
}
