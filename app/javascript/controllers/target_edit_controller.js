import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "display"]

  show() {
    this.formTarget.classList.toggle("d-none")
    this.displayTarget.classList.toggle("d-none")
  }
}
