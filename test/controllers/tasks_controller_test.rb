require "test_helper"

class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks
  def index
    @tasks = current_user.tasks
  end

  # GET /tasks/1
  def show
  end

  # GET /tasks/new
  def new
    @task = current_user.tasks.build
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      redirect_to @task, notice: "Task was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      redirect_to @task, notice: "Task was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    redirect_to tasks_url, notice: "Task was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      # Using current_user.tasks ensures users can only access their own tasks
      @task = current_user.tasks.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to tasks_path, alert: "Task not found."
    end

    # Only allow a list of trusted parameters through.
    # We fixed 'desription' to 'description' here!
    def task_params
      params.require(:task).permit(:title, :description, :due_date, :status)
    end
end
