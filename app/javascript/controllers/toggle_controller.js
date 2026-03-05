import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["icon", "hideable", "content", "sidebar", "floatingBtn"]

  connect() {
    console.log(this.iconTargets)
    console.log(this.hideableTarget)}

    call(event) {
    event.preventDefault()

    this.hideableTarget.classList.toggle("d-none")

    this.iconTargets.forEach(icon => {
      icon.classList.toggle("d-none")
    })
  }

  closeSidebarOnHome() {
  if (document.body.dataset.page === "root") {
    this.closeSidebar()
  }
}

   toggle() {
    const sidebar = this.sidebarTarget
    const content = this.contentTarget
    const floatingBtn = this.floatingBtnTarget

    sidebar.classList.toggle("d-none")

    if (sidebar.classList.contains("d-none")) {
      content.classList.remove("content-marge")
      floatingBtn.classList.remove("d-none")
    } else {
      content.classList.add("content-marge")
      floatingBtn.classList.add("d-none")
    }
  }

}
