import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["bottom"]

  connect() {
    requestAnimationFrame(() => {
      this.scrollToBottom()
    })
  }

  scrollToBottom() {
    this.bottomTarget.scrollIntoView({
      behavior: "auto",
      block: "end"
    })
  }
}
