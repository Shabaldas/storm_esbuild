import Carousel from "stimulus-carousel";

export default class extends Carousel {
  connect() {
    super.connect();
    this.swiper;
    this.defaultOptions;
  }
  get defaultOptions() {
    return {
      clickable: true,
      spaceBetween: 24,
      pagination: { el: ".swiper-pagination" },
      navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev",
      },
    };
  }
}
