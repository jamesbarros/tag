class TasksController < ApplicationController
  before_action :authenticate_user!, except: [:index] # removed :show 4 accept_task options
  before_action :set_task, only: [:show, :edit, :update, :destroy] # Task (params[:id])
  before_action :current_user_is_task_user_id, only: [:edit, :update, :destroy] # restrict non-owners

  # GET /tasks
  # GET /tasks.json
  def index
    @task_check = Task.all
    # need to list only Task that is not current_user
    if user_signed_in?
      @my_id = current_user.id

      # All Available task not current_user & checks for accepted_by_user_id == 0
      # This works to show all available task not of current user that's available to accept
      # worked only after setting accepted_by_user_id to = 0 on init via after_initialize task.rb
      @tasks = Task.where("user_id != ? AND task_status = ? AND accepted_by_user_id = ?", @my_id, "available", 0)
    else
      # All Available task including my tasks : user_signed_in?(false) => index display
      @tasks = Task.where(task_status: "available")
      # Link clickable to accept Task logic goes here
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
      @my_id = current_user.id

      # task.update( {:accepted_by_user_id => current_user.id}, {:task_status => "processing"} )

      # This is in show page.. I don't know if I want a link there with parameters or
      # a boolean value that hits an end point here which would update the db which is safer?
      #
      #link_to("TAG", task_path(@task, :accepted_by_user_id => current_user.id), :method => :put, :confirm => "Accept this TAG? ")
  end

  # GET /tasks/new
  def new
    @task = current_user.tasks.build # Task.new
    @my_task_status_options = {available: "available", unlist: "unlisted"}
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
        format.html { redirect_to tasks_url, notice: 'Task was successfully Removed.' }
        format.json { head :no_content }
      end
  end



  # Task of current_user which have an accepted_by_id
  def my_task_accepted_by_another_user_id # accepted_by_id, != nil
    @my_id = current_user.id
    # @other_user_id = Task.where(user_id: @my_id, accepted_by_id: != nil) # !empty?) # preset to nil
    @tasks = Task.where(user_id: @my_id, accepted_by_id: any?) # if !empty? doens't work != nil may
    # @tasks = Task.where(user_id: !current_user, accepted_by_user_id: nil, task_status: "available")
  end

  # Task accepted_by_current_user of other_user_id
  def other_user_task_accepted_by_current_user
    @my_id = current_user.id # redundant?
    @task = Task.where(accepted_by_id: @my_id)
    @other_user_task_status_options = {finished: "finished", processing: "processing", error_in_tag: "errors in TAG", Return_Tag: "Please_remove_me"}
  end

  # Task of current_user Linked as My-TAG's in application.html.erb
  def my_task
    @my_id = current_user.id # may be redundant but will head towards service objects
    @tasks = Task.where(user_id: @my_id)
  end


  private
  # current_user must validate as task_user_id to Edit / Update / Delete
    def current_user_is_task_user_id
       @my_task_status_options = {available: "available", finished: "Finished '4 Review'", complete: "Complete 'n Pay'", unlist: "unlisted", processing: "processing"} # this transfers over to _form via edit call
      if current_user.id != @task.user_id
        redirect_to tasks_path
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id]) # OG
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :date, :price, :detail, :location, :task_status, :accepted_by_user_id)
    end
end
