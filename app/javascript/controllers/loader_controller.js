import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["loaderone", "color", "material", "size", "form"]
  
  connect() {
    console.log("YESSS");
  }

  showLoader(e) {
    console.log("show loader");
    // const form = 

    this.loaderoneTarget.classList.toggle("hidden");;
  }
}
