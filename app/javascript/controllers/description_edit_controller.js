import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["display", "form", "text", "input"]

  connect() {
    const savedDescription = localStorage.getItem("profileDescription")

    if (savedDescription) {
      this.textTarget.textContent = savedDescription
      this.textTarget.classList.remove("text-muted")
    }
  }

  show() {
    const currentText = this.textTarget.textContent.trim()

    if (currentText === "Renseignez votre description...") {
      this.inputTarget.value = ""
    } else {
      this.inputTarget.value = currentText
    }

    this.displayTarget.classList.add("d-none")
    this.formTarget.classList.remove("d-none")
  }

  hide() {
    this.formTarget.classList.add("d-none")
    this.displayTarget.classList.remove("d-none")
  }

  save() {
    const newDescription = this.inputTarget.value.trim()

    if (newDescription === "") {
      this.textTarget.textContent = "Renseignez votre description..."
      this.textTarget.classList.add("text-muted")
      localStorage.removeItem("profileDescription")
    } else {
      this.textTarget.textContent = newDescription
      this.textTarget.classList.remove("text-muted")
      localStorage.setItem("profileDescription", newDescription)
    }

    this.hide()
  }
}
