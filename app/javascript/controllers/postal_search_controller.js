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
    const districtId = event.target.value;
    if (!districtId) return;

    // Show loading state
    this.neighborhoodSelectTarget.innerHTML = '<option value="">Loading...</option>';
    this.resetResults(); // Clear previous results

    fetch(`/${this.locale}/districts/${districtId}/neighborhoods.js`)
      .then(response => {
        if (!response.ok) throw new Error("Network response was not ok");
        return response.text();
      })
      .then(html => {
        this.neighborhoodSelectTarget.innerHTML = html;
        this.neighborhoodSelectTarget.disabled = false;
      })
      .catch(error => {
        console.error("Error loading neighborhoods:", error);
        this.neighborhoodSelectTarget.innerHTML = '<option value="">Error loading neighborhoods</option>';
      });
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