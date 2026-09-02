import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel", "option"]

  show(event) {
    const index = event.params.index
    this.panelTargets.forEach((panel, i) => {
      panel.classList.toggle("active", i === index)
    })

    this.optionTargets.forEach((option, i) => {
      option.classList.toggle("active", i === index)
    })
  }
}
