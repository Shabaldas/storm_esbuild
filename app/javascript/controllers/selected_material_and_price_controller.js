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
    const frame25 = document.getElementById('printing_sla_25');
    const frame35 = document.getElementById('printing_sla_35');
    const frame50 = document.getElementById('printing_sla_50');
    frame25.src=event.target.value;
    frame35.src=event.target.value;
    frame50.src=event.target.value;
    frame25.reload();
    frame35.reload();
    frame50.reload();
  }
  
  changeDlp(event) {
    const frame25 = document.getElementById('printing_dlp_25');
    const frame35 = document.getElementById('printing_dlp_35');
    const frame50 = document.getElementById('printing_dlp_50');
    frame25.src=event.target.value;
    frame35.src=event.target.value;
    frame50.src=event.target.value;
    frame25.reload();
    frame35.reload();
    frame50.reload();
  }
}
