import { Controller } from "@hotwired/stimulus"
import { Toast } from "bootstrap"

export default class extends Controller {
  initialize() {
    this.toastTypes = {
      default: "toast text-center",
      warning: "toast red-light red-border text-danger text-center"
    }

    this.toast = new Toast(
      document.getElementById("toast")
    )
  }

  show({ detail: { type = "default", content }}) {
    this.toast._element.classList = this.toastTypes[type]
    this.toast._element.querySelector('.toast-body').innerText = content
    this.toast.show()
  }
}
