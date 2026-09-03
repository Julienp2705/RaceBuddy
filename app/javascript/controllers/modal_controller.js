import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    console.log("Hello")
    const modal = new bootstrap.Modal(this.element)
    modal.show()
  }
}
