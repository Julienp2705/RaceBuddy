import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = { lat: Number, lng: Number, buddies: Array }

  connect() {
    mapboxgl.accessToken = document.querySelector('meta[name="mapbox-token"]').content

    const map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v12",
      center: [this.lngValue, this.latValue],
      zoom: 11
    })

    new mapboxgl.Marker()
      .setLngLat([this.lngValue, this.latValue])
      .addTo(map)

    this.buddiesValue.forEach((buddy) => {
      const el = document.createElement("div")

    if (buddy.avatar_url) {
      const img = document.createElement("img")
      img.src = buddy.avatar_url
      img.classList.add("avatar-bordered")
      el.appendChild(img)
    } else {
      el.classList.add("buddy-pin-fallback")
      el.textContent = buddy.initials
    }

      new mapboxgl.Marker(el)
        .setLngLat([buddy.lng, buddy.lat])
        .addTo(map)
    })
  }
}
