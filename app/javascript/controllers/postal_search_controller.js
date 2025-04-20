// app/javascript/controllers/postal_search_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["districtSelect", "neighborhoodSelect", "results"]

  loadDistricts(event) {
    if (!this.hasDistrictSelectTarget || !this.hasResultsTarget) {
      console.error("Missing required targets")
      return
    }
    
    const provinceId = event.target.value
    this.districtSelectTarget.innerHTML = '<option value="">Loading...</option>'
    this.resetLowerSelects()
    
    fetch(`/${this.locale}/provinces/${provinceId}/districts.js`)
      .then(response => response.text())
      .then(html => {
        this.districtSelectTarget.innerHTML = html
        this.districtSelectTarget.disabled = false
      })
  }

  loadNeighborhoods(event) {
    const districtId = event.target.value
    this.neighborhoodSelectTarget.innerHTML = '<option value="">Loading...</option>'
    this.resetResults()
    
    fetch(`/${this.locale}/districts/${districtId}/neighborhoods.js`)
      .then(response => response.text())
      .then(html => {
        this.neighborhoodSelectTarget.innerHTML = html
        this.neighborhoodSelectTarget.disabled = false
      })
  }

  resetLowerSelects() {
    this.neighborhoodSelectTarget.innerHTML = '<option value="">Select Neighborhood</option>'
    this.neighborhoodSelectTarget.disabled = true
    this.resetResults()
  }

  resetResults() {
    this.resultsTarget.innerHTML = ''
  }

  get locale() {
    return document.documentElement.lang || 'en'
  }
}