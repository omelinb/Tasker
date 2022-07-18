class TasksController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_task, only: %i[show change_status]
  before_action :is_creator?, only: :change_status
  before_action :validate_params, only: :change_status

  def index
    # Get all records because we don't expect a lot of data
    @tasks = Task.dashboard_fields.ordered
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

  def change_status
    @task.send("#{params[:event]}!")

    render 'tasks/_task', layout: false, locals: { task: @task }
  end

  private

  def task_params
    params.required(:task).permit(:title, :deadline_at)
  end

  def validate_params
    return if StatusChangeCheckService.call(@task, params[:event])

    head :unprocessable_entity
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def is_creator?
    current_user == @task&.creator
  end
end
