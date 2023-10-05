import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // 

  // IMPORTANT CAND ADD HTML STYLES IN THIS CONTOLLER
  // WE SHOULD USE CLASESS FROM PREVIOUS IMAGES
  connect() {
    const imageContainer = this.element.querySelector(".image-container");
    const spinner = this.element.querySelector(".spinner");

    const image = new Image();
    const originalImage = imageContainer.querySelector("img");
    image.src = originalImage.src;

    image.classList.add("mx-auto", "my-auto");

    image.onload = () => {
      spinner.style.display = "none"; // Hide the spinner when the image is loaded
      imageContainer.style.display = "block"; // Show the image container
      imageContainer.classList.add("w-full", "h-[240px]", "my-2");
    };
  }
}
