class TasksController < ApplicationController
  before_action :set_task, only: [:update, :destroy]

  def index
    @tasks = Task.all
    render json: @tasks
  end

  def create
    @task = Task.new(task_params)
    return render json: @task, status: :created, location: @task if @task.save
    render json: @task.errors, status: :unprocessable_entity
  end

  def update
    return render json: @task if @task.update(task_params)
    render json: @task.errors, status: :unprocessable_entity
  end

  def destroy
    @task.destroy
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :due_date, :is_completed)
  end
end
