class ApprovalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: :create
  before_action :is_creator?, only: :create

  def create
    approval = Approval.new(task: @task, user: current_user)

    if approval.save
      head :created
    else
      head :forbidden
    end
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end

  def is_creator?
    return unless current_user == @task&.creator

    head :forbidden
  end
end
