import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["sidebarContainer"];

  connect() {}

  toggle(e) {
    if (this.sidebarContainerTarget.dataset.expanded === "1") {
      this.expand();
    } else {
      this.collapse();
    }
  }

  expand() {
    this.sidebarContainerTarget.classList.remove("-translate-x-full");
    this.sidebarContainerTarget.dataset.expanded = "0";
    document.body.style.overflow = "hidden";
  }

  collapse() {
    this.sidebarContainerTarget.classList.add("-translate-x-full");
    this.sidebarContainerTarget.dataset.expanded = "1";
    document.body.style.overflow = "visible";
  }
}
