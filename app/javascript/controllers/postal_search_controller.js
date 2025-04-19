// app/javascript/controllers/postal_search_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["districtSelect", "neighborhoodSelect"]

  connect() {
    console.log("PostalSearch controller connected!"); // Test connection
  }

  loadDistricts(event) {
    console.log("Province changed!"); // Debug line
    const provinceId = event.target.value;
    if (!provinceId) return;

    debugger;
    fetch('/provinces/'+provinceId+'/districts.js')
      .then(response => {
        if (!response.ok) throw new Error("Network response was not ok");
        return response.text();
      })
      .then(html => {
        console.log("Received districts:", html); // Debug response
        this.districtSelectTarget.innerHTML = html;
        this.districtSelectTarget.disabled = false;
      })
      .catch(error => console.error("Fetch error:", error));
  }

  // ... rest of the code
}