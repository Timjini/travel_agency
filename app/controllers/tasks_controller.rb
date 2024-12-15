class TasksController < ApplicationController
  before_action :set_task, only: [ :show, :edit, :update, :destroy ]

  def index
    @task = Task.new
    @tasks = Task.all
  end

  def show
    @post = Post.find(params[:id])
    render turbo_stream: turbo_stream.replace("task_#{@task.id}", partial: "tasks/task", locals: { post: @task })
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      @task.set_translation(:name, params[:task][:translations_pl_name], "pl")
      @task.set_translation(:name, params[:task][:name], "en")
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            # use flash if needed
            # turbo_stream.replace("flash_messages", partial: "shared/flash_messages", locals: { flash_message: flash[:notice] }),
            turbo_stream.prepend("tasks", partial: "tasks/task", locals: { task: @task }),
            turbo_stream.replace("task_form", partial: "tasks/form", locals: { task: Task.new })
          ]
        end
        format.html { redirect_to tasks_url, notice: "Task created." }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("task_form", partial: "tasks/form", locals: { task: @task })
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @task = Task.find(params[:id])
    render turbo_stream: turbo_stream.replace("task_#{@task.id}", partial: "tasks/edit_form", locals: { task: @task })
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("task_form_#{@task.id}", partial: "tasks/task", locals: { task: @task })
        end
        format.html { redirect_to tasks_url, notice: "Task updated." }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("task_form_#{@task.id}", partial: "tasks/edit_form", locals: { task: @task })
        end
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
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
