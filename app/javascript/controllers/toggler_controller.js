import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "input", "hideme" ];

  connect() {
    this.toggle();
  }

  toggle() { 
    if (this.inputTarget.checked) {
      this.hidemeTarget.style.display = "block";
    } else {
      this.hidemeTarget.style.display = "none";
    }
  }
}
