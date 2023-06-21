import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ["uploadContainer", "viewContainer", "settingsContainer", "orderContainer"];

  connect() {

    this.viewContainerTarget.style.display = "none";
    this.settingsContainerTarget.style.opacity = "0.3";
    this.orderContainerTarget.style.display = "none";

    document.getElementById("file").addEventListener("change", (e) => {
      const files = e.target.files;
      const file = files[0];
      if (file) {
        this.uploadContainerTarget.style.display = "none";
        this.viewContainerTarget.style.display = "block";
        this.settingsContainerTarget.style.opacity = "1";
        this.orderContainerTarget.style.display = "block";
      }
      return;
    });
  };
};
