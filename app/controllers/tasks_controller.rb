class TasksController < ApplicationController
  BOARD_FIELDS = %i[id title status approvals_count creator_id].freeze

  def index
    @new_tasks = Task.select(BOARD_FIELDS).new_tasks
    @in_progress_tasks = Task.select(BOARD_FIELDS).in_progress
    @completed_tasks = Task.select(BOARD_FIELDS).completed
    @canceled_tasks = Task.select(BOARD_FIELDS).canceled
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.creator = current_user

    if @task.save
      redirect_to action: :index
    else
      render :new
    end
  end

  private

  def task_params
    params.required(:task).permit(:title, :deadline_at)
  end
end
