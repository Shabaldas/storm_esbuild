import { Controller } from "@hotwired/stimulus"
import 'tom-select'
import TomSelect from 'tom-select'

export default class extends Controller {
  connect() {
    this.select = new TomSelect(this.element, { 
      closeAfterSelect: true,
      render: {
        no_results:function(data,escape){
          return '<div class="no-results p-2">No results found for "'+escape(data.input)+'"</div>';
        },
      }
    })
  }

  disconnect() {
    this.select.destroy()
  }
}
