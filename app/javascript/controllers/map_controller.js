import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = { lat: Number, lng: Number }

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
  }
}
