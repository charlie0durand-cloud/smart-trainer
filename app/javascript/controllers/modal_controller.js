import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  open() {
    document.getElementById("modal-routine").classList.add("active")
  }

  close() {
    document.getElementById("modal-routine").classList.remove("active")
  }
}
