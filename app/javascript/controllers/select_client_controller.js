import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  updateLink(event) {
    const selectedClientId = event.target.value;
    const clientLink = document.getElementById("client-link");
    const select = event.target;

    if (selectedClientId) {
      const selectedOption = select.options[select.selectedIndex];
      const clientName = selectedOption.textContent;
      const clientUrl = `/dredd/clients/${selectedClientId}`;
      
      clientLink.href = clientUrl;
      clientLink.textContent = `Link to ${clientName}`;
    } else {
      clientLink.removeAttribute("href");
    }
  }
}
