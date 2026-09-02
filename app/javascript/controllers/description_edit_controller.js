import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["display", "form", "text", "input"]
  static values = { url: String }

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

  async save() {
    const newDescription = this.inputTarget.value.trim()

    const response = await fetch(this.urlValue, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ user: { description: newDescription } })
    })

    if (!response.ok) return

    const data = await response.json()

    if (data.description) {
      this.textTarget.textContent = data.description
      this.textTarget.classList.remove("text-muted")
    } else {
      this.textTarget.textContent = "Renseignez votre description..."
      this.textTarget.classList.add("text-muted")
    }

    this.hide()
  }
}
