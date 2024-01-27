import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['address', 'latitude', 'longitude', 'form', 'weather']

  initialize() {
    const autocomplete = null
    const place = null
    this.placeChanged = this.placeChanged.bind(this)
  }

  connect() {
    if (typeof google !== 'undefined') {
      this.initAutocomplete()
    }
  }

  initAutocomplete() {
    this.autocomplete = new google.maps.places.Autocomplete(this.addressTarget, this.autocompleteOptions)
    this.autocomplete.addListener('place_changed', this.placeChanged)
  }

  autocompleteOptions() {
    return {
      types: ['geocode'],
      fields: ['name', 'geometry']
    }
  }

  placeChanged() {
    this.setGeometry()
    this.formTarget.requestSubmit()
  }

  setGeometry() {
    this.place = this.autocomplete.getPlace()
    const geometry = JSON.stringify(this.place.geometry.location)
    const object_geometry = JSON.parse(geometry)
    this.latitudeTarget.value = object_geometry.lat
    this.longitudeTarget.value = object_geometry.lng
  }

  manualTyping(event) {
    this.clearWeatherInfo(event)
    this.preventSubmit(event)
  }

  clearWeatherInfo(event) {
    if (this.hasWeatherTarget && event.key === "Backspace" &&
      (this.addressTarget.value.trim().length <= 1 || event.metaKey)) {
      this.weatherTarget.textContent = ''
    }
  }

  preventSubmit(event) {
    if (event.code === 'Enter') {
      event.preventDefault()
    }
  }
}
