import { Controller } from "@hotwired/stimulus";

var arrow_up = `<svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 15l7-7 7 7" /></svg>`;
var arrow_down = `<svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" /></svg>`;

export default class extends Controller {
  static targets = ["accContent", "accTitle", "accordionIcon"];

  connect() {
    if (this.hasAccordionIconTarget) {
      this.accordionIconTargets.forEach(
        (item) => (item.innerHTML = arrow_down)
      );
    }
  }

  toggle(e) {
    var activeTitle = e.target.closest("#acc_btn");

    if (e.target.type === "checkbox") return;

    if (activeTitle.classList.contains("active-dropdown")) {
      activeTitle.classList.remove("active-dropdown");
      activeTitle.nextElementSibling.classList.add("hidden");

      if (this.hasAccordionIconTarget) {
        activeTitle.children[1].innerHTML = arrow_down;
      }
      return;
    }

    if (this.hasAccordionIconTarget) {
      activeTitle.children[1].innerHTML = arrow_up;
    }
    activeTitle.nextElementSibling.classList.remove("hidden");
    activeTitle.classList.add("active-dropdown");
  }
}
