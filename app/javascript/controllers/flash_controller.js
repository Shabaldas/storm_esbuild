import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.dismiss();
    }, 2000);
  }

  dismiss() {
    this.element.remove();
  }
}
