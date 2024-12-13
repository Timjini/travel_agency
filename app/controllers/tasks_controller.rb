class TasksController < ApplicationController
  before_action :set_task, only: [ :show, :edit, :update, :destroy ]

  def index
    @task = Task.new
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def create
  @task = Task.new(task_params)

    if @task.save
      # Set translations
      @task.set_translation(:name, params[:task][:translations_pl_name], "pl")
      @task.set_translation(:name, params[:task][:name], "en")
       respond_to do |format|
        format.html { redirect_to task_path(@task), notice: "Date was successfully created." }
        format.turbo_stream { flash.now[:notice] = "Date was successfully created." }
      end
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
