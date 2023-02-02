import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static get targets() {
    return ['child', 'parent', 'default']
  }

  toggleSelection(evt) {
    if (!this.hasParentTarget) return
    
    if (evt.currentTarget == this.parentTarget) {
      let childrenChecked = this.compute('children-checked-if')
      for (let child of this.childTargets) {
        child.checked = childrenChecked
      }
      if (this.hasDefaultTarget) {
        let defaultChecked = this.compute('default-checked-if')
        for (let defaultChild of this.defaultTargets) {
          defaultChild.checked = defaultChecked
        }
      }
    } else {
      this.parentTarget.checked = this.compute('parent-checked-if')
      this.parentTarget.indeterminate = this.compute('parent-indeterminate-if')
    }
  }
  
  compute(attribute) {
    if (!this.data.has(attribute)) return false

    const me = this
    const attributeValue = this.data.get(attribute)
    const functionValues = attributeValue.split('&').map((functionName) => me[functionName]())

    return functionValues.every((bool) => bool === true)
  }
  
  allChildrenChecked() {
    return this.checkedChildrenTargets.length == this.childTargets.length
  }
  
  anyChildrenChecked() {
    return this.checkedChildrenTargets.length > 0
  }
  
  noChildrenChecked() {
    return this.checkedChildrenTargets.length == 0
  }
  
  parentChecked() {
    return this.parentTarget.checked == true
  }

  get checkedChildrenTargets() {
    return this.childTargets
               .filter(child => child.checked)
  }
}
