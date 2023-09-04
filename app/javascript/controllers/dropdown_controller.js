import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["link"]

  connect() {
    console.log("dropdown connect")
  }

  show(e) {
    e.preventDefault()
    this.linkTarget.classList.remove("hidden");
  }

  hide(e) {
    e.preventDefault()
    this.linkTarget.classList.add("hidden");
  }
}
