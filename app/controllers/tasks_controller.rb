class TasksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show] # task only shows to authenticate_users
  before_action :set_task, only: [:show, :edit, :update, :destroy] # Task (params[:id])
  before_action :current_user_is_task_user_id, only: [:edit, :update, :destroy] # restrict non-owners


  # Task of current_user Linked as My-TAG's in application.html.erb
  def my_task
    @my_id = current_user.id # may be redundant but will head towards service objects
    @tasks = Task.where(user_id: @my_id)
    # @tasks = Task.where(user_id: current_user.id) # works fine above is alternative
  end

  # Task of current_user which have an accepted_by_id
  def my_task_accepted_by_another_user_id # accepted_by_id, how to acquire this?
    @my_id = current_user.id
    # @other_user_id = Task.where(user_id: @my_id, accepted_by_id: !empty?)
    @tasks = Task.where(user_id: @my_id, accepted_by_id: @other_user_id) # need to figure other_user_id
  end

  # Task of accepted_task by current_user
  def accepted_task
    @my_id = current_user.id # redundant?
    @task = Task.where(accepted_by_id: @my_id)
  end


  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = current_user.tasks.build # Task.new
  end

  # GET /tasks/1/edit
  def edit
      @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = current_user.tasks.build(task_params)  # Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    # if current_user.id != @task.user_id # this is in the private method below
    #   redirect_to tasks_path
    # else
      @task.destroy
      respond_to do |format|
        format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
        format.json { head :no_content }
      end
    # end # this is in the private method below
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id]) # OG
      # @task  = Task.where(current_user.id: @task.user_id) # didnt check mostly breaks I bets
      # @tasks = Task.where(user_id: current_user.id) # This DOES break edit/delete/show
      # @tasks = Task.where(user_id: params[:id]) # not working yet
    end

    # current_user must validate as task_user_id to Edit / Update / Delete
    def current_user_is_task_user_id
      if current_user.id != @task.user_id
        redirect_to tasks_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :date, :price, :detail, :location)
    end
end
