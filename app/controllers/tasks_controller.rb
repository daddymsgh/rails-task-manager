class TasksController < ApplicationController

  def new
    # this is for the form builder (with will build the path + method)
    @task = Task.new
  end

  # we can only trigger this action, by submitting a form
  # it's only purpose is to create, so it doesnt have a view
  def create
    @task = Task.new(task_params)
    if @task.save
      # redirect_to tasks_path
      redirect_to task_path(@task)
    else
      # if the task doesnt save, we want to show the form again
      # render the form page again aka new.html.erb
      render :new, status: :unprocessable_entity # 422
    end
  end


  def show
    # Rails pulls the id from the URL and puts in the params
    @task = Task.find(params[:id])
  end

  def index
    @tasks = Task.all
  end

  def edit
    # this is just for the form
    @task = Task.find(params[:id])
  end

  # we can only trigger this action, by submitting a form
  # it's only purpose is to update, so it doesnt have a view
  def update
    # load the task using the id from the URL (not the form)
    @task = Task.find(params[:id])
    # update the instance using the data from the form
    if @task.update(task_params)
      redirect_to task_path(@task)
    else
      # if the task doesnt save, we want to show the form again
      # render the form page again aka new.html.erb
      render :edit, status: :unprocessable_entity # 422
    end
  end


  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, status: :see_other
  end

  private

  def task_params
    params.require(:task).permit(:title, :details, :completed)
  end

end
