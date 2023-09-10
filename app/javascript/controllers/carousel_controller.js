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
    };
  }
}
