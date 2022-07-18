import { Controller } from "@hotwired/stimulus"
import { post } from "@rails/request.js"

export default class extends Controller {
  static targets = [ "approval", "task" ]

  async addApproval() {
    const taskId = this.taskTarget.id.split("_")[1]
    const response = await post(`/tasks/${taskId}/approvals`)

    if (response.ok) {
      let approvalsCount = parseInt(this.approvalTarget.innerText) + 1
      this.approvalTarget.innerText = `+${approvalsCount}`
    }
  }
}
