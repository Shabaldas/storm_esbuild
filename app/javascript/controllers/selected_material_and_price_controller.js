import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  changeFdm(event) {
    const frame100 = document.getElementById('printing_100');
    const frame200 = document.getElementById('printing_200');
    const frame300 = document.getElementById('printing_300');
    frame100.src=event.target.value;
    frame200.src=event.target.value;
    frame300.src=event.target.value;
    frame100.reload();
    frame200.reload();
    frame300.reload();
  }

  changeSla(event) {
    
  }
  changeDlp(event) {

  }

}
