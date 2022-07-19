import { Controller } from "@hotwired/stimulus"
import { patch } from "@rails/request.js"

export default class extends Controller {
  async startTask() {
    await this.changeStatus("start", "in_progress")
  }

  async completeTask() {
    await this.changeStatus("complete", "completed")
  }

  async cancelTask() {
    await this.changeStatus("cancel", "canceled")
  }

  async changeStatus(eventName, expectedStatus) {
    const taskId = this.element.id.split("_")[1]
    const response = await patch(`/tasks/${taskId}/change_status/${eventName}`)

    if (response.ok) {
      const html = await response.html
      this.moveTask(html, expectedStatus)
    } else {
      this.dispatch("forbidden", {
        detail: {
          type: "warning",
          content: "Sorry, you can't do this action"
        }
      })
    }
  }

  moveTask(html, expectedStatus) {
    this.element.remove()
    const tasksColumnId = `tasks_${expectedStatus}`
    const taskElement = document.createRange().createContextualFragment(html)
    document.getElementById(tasksColumnId).after(taskElement)
  }
}
