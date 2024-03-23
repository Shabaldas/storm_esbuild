import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Loader controller connected");
  }

  show() {
    this.element.classList.remove("hidden");
  }

  hide() {
    this.element.classList.add("hidden");
  }
}