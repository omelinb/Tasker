class TasksController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_task, only: %i[show change_status]
  before_action :check_creator, only: :change_status
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
    head :unprocessable_entity unless StatusChangeCheckService.call(@task, params[:event])
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def check_creator
    head :forbidden unless current_user == @task&.creator
  end
end
