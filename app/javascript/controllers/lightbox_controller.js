import Lightbox from "stimulus-lightbox";

export default class extends Lightbox {
  connect() {
    super.connect();
    this.lightGallery;
    this.defaultOptions;
  }

  get defaultOptions() {
    return {
      index: 0,
      controls: true,
      closable: true,
      counter: true,
      loop: true,
      download: false,
      selector: ".lightbox-item",
      mobileSettings: {
        showCloseIcon: true,
        download: false,
        controls: false,
      },
    };
  }
}
