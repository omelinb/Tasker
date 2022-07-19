import { Controller } from "@hotwired/stimulus"
import { post } from "@rails/request.js"

export default class extends Controller {
  static values = {
    taskId: Number,
    approvalsCount: Number
  }

  async addApproval() {
    const response = await post(`/tasks/${this.taskIdValue}/approvals`)

    if (response.ok) {
      this.element.innerText = `+${this.approvalsCountValue + 1}`
    } else {
      this.dispatch("forbidden", {
        detail: {
          type: "warning",
          content: "Sorry, you can't approve this task"
        }
      })
    }
  }
}
