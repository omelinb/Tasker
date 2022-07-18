class StatusChangeCheckService < ApplicationService
  def initialize(task, event)
    @task = task
    @event = event
  end

  def call
    return false unless @task.send("may_#{@event}?")
    return true if %w[start cancel].include?(@event)
    return true if @task.approvals_count > 2

    other_approvers_count > 1
  end

  def other_approvers_count
    (@task.approvals.map(&:user_id) - [@task.creator_id]).size
  end
end
