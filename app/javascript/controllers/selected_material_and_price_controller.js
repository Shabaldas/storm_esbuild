import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["onegramm", "fifthgramm", "hundredthgramm", "hundredandfiftygramm"]

  connect() {
    console.log("connectLOL");
  }

  changePrice(e) {
    console.log(e.target);
    const selector = e.target;
    console.log(selector.selectedIndex);
    const currentPrice = +selector.options[selector.selectedIndex];
    console.log(currentPrice);
  //   const currentPrice = +selector.options[selector.selectedIndex].dataset.price;
  //   this.priceTarget.textContent = `₴ ${currentPrice}`;
  }
}
