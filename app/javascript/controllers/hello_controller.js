import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["output"]
  
  connect() {
    console.log("Hello controller connected!")
  }

  greet() {
    this.outputTarget.textContent = "Button clicked at: " + new Date().toLocaleTimeString()
  }

  // Optional: Method with parameters
  customGreet(event) {
    const name = event.params.name
    this.outputTarget.textContent = `Hello, ${name}!`
  }
}
