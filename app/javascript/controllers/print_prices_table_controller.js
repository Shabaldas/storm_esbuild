import { Controller } from "@hotwired/stimulus";

var materialPrices = {
  ABS: {
    100: {
      rows: [
        ["1", "12"],
        ["2", "24"],
        ["3", "36"],
      ],
    },
    200: {
      rows: [
        ["1", "20"],
        ["2", "40"],
        ["3", "60"],
      ],
    },
    300: {
      rows: [
        ["1", "100"],
        ["2", "120"],
        ["3", "150"],
      ],
    },
  },
  PLA: {
    100: {
      rows: [
        ["1", "120"],
        ["2", "240"],
        ["3", "360"],
      ],
    },
    200: {
      rows: [
        ["1", "200"],
        ["2", "400"],
        ["3", "600"],
      ],
    },
    300: {
      rows: [
        ["1", "1000"],
        ["2", "1200"],
        ["3", "1500"],
      ],
    },
  },
};



export default class extends Controller {
  static targets = ["materialSelect"];

  connect() {
    const target = this.materialSelectTarget.value;
    this.renderTables(target);
  }

  change(e) {
    const selectedMaterilaValue = e.target.value;
    this.renderTables(selectedMaterilaValue);
  }

  renderTables(selectedMaterial) {
    let container = document.querySelector(".material-prices-tables");
    let templateTables = materialPrices[selectedMaterial];
    let tablesHTML = "";

    Object.entries(templateTables).forEach(([key, prices]) => {
      let tableHTML = `
      <table class="w-full text-sm text-left text-dark-blue">
        <caption class="pb-1.5 text-left text-2xl md:text-4xl text-dark-blue">
          ${key} mrc
        </caption>
        <thead class="text-xs text-dark-blue uppercase">
          <tr class="border-b-2 border-t-2 border-solid border-dark-blue">
            <th
              scope="col"
              class="py-1.5 px-4 text-base normal-case font-normal"
            >
              Quantity
            </th>
            <th
              scope="col"
              class="py-1.5 px-4 text-base normal-case font-normal"
            >
              Price
            </th>
          </tr>
        </thead>
        <tbody>
          ${prices.rows
            .map(
              (rowElem) =>
                `<tr class="border-b-1 border-solid border-dark-blue">
                  <td class="py-1.5 px-4 text-base font-medium">${rowElem[0]}g</td>
                  <td class="py-1.5 px-4 text-base font-medium">${rowElem[1]} hrn/g</td>
                </tr>`
            )
            .join("")}
        </tbody>
      </table>`;

      tablesHTML += tableHTML;
    });

    container.innerHTML = tablesHTML;
  }
}
