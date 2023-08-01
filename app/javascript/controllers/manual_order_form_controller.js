// app/javascript/controllers/order_form_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "priceModeling",
    "pricePrinting",
    "count",
    "totalPrice",
    "previewPrice",
  ];

  connect() {
    console.log("Hello from ManualOrderFormController");
    this.calculateTotalPrice();
  }

  calculateTotalPrice() {
    const priceModeling = parseFloat(this.priceModelingTarget.value) || 0;
    const pricePrinting = parseFloat(this.pricePrintingTarget.value) || 0;
    const count = parseInt(this.countTarget.value) || 1;

    const totalPrice = (priceModeling + pricePrinting) * count
    this.totalPriceTarget.value = isNaN(totalPrice) ? "" : totalPrice.toFixed(2);

    // Display the calculated total price as the preview price
    if (isNaN(totalPrice)) {
      totalPrice = (priceModeling + pricePrinting) * count
      this.totalPriceTarget.value = isNaN(totalPrice) ? "" : totalPrice.toFixed(2);
    } else {
      this.priceModelingTarget.value = "0";
      this.pricePrintingTarget.value = "0";
    }
  }

  updateCustomTotalPrice(event) {
    // When the user manually inputs a custom total price, update the preview price
    const customTotalPrice = parseFloat(event.target.value);
    this.previewPriceTarget.textContent = isNaN(customTotalPrice) ? "≈ 0 грн" : `≈ ${customTotalPrice.toFixed(2)} грн`;
  }

  updatePreviewOnInput() {
    this.calculateTotalPrice();
  }
}