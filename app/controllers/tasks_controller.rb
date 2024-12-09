class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @task = Task.new
    @tasks = Task.all
  end

  def show
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      @task.set_translation(:name, params[:task][:translations_pl_name], "pl")
      @task.set_translation(:name, params[:task][:name], "en")
      render turbo_stream: turbo_stream.append("tasks", partial: "task", locals: { task: @task })
    else
      render :index
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @task.destroy
    render turbo_stream: turbo_stream.remove(@task)
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :completed)
  end
end
