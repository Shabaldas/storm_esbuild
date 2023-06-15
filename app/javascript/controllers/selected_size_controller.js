import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["price"]

  changePrice(e) {
    const selector = e.target;
    const currentPrice = +selector.options[selector.selectedIndex].dataset.price;
    this.priceTarget.textContent = `₴ ${currentPrice}`;
  }
}
