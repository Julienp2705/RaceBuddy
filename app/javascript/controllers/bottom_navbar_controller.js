import { Controller } from "@hotwired/stimulus"

// Positions the sliding "glass pill" behind whichever bottom-navbar item
// the server marked active (bottom-navbar__item--active). No hover preview,
// no click interception: every tap is a real Turbo navigation, the pill
// just springs into place on load / resize.
export default class extends Controller {
  static targets = ["item", "pill"]

  connect() {
    // Position instantly on first paint, then re-enable the spring
    // transition on the next frame so later moves (e.g. resize) animate.
    this.pillTarget.classList.add("bottom-navbar__pill--no-transition")
    this.moveToActive()

    requestAnimationFrame(() => {
      this.pillTarget.classList.remove("bottom-navbar__pill--no-transition")
    })

    this.resizeHandler = () => this.moveToActive()
    window.addEventListener("resize", this.resizeHandler)
  }

  disconnect() {
    window.removeEventListener("resize", this.resizeHandler)
  }

  moveToActive() {
    const active = this.itemTargets.find((item) =>
      item.classList.contains("bottom-navbar__item--active")
    )

    if (!active) {
      // No tab matches the current page (e.g. a race or chat sub-page) —
      // hide the pill rather than guessing which tab to highlight.
      this.pillTarget.classList.remove("bottom-navbar__pill--visible")
      return
    }

    const barRect = this.element.getBoundingClientRect()
    const itemRect = active.getBoundingClientRect()

    this.pillTarget.style.left = `${itemRect.left - barRect.left}px`
    this.pillTarget.style.width = `${itemRect.width}px`
    this.pillTarget.classList.add("bottom-navbar__pill--visible")
  }
}
