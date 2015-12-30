class TasksController < ApplicationController
  before_action :authenticate_user!, except: [:index] # removed :show 4 accept_task options
  before_action :set_task, only: [:show, :edit, :update, :destroy] # Task (params[:id])
  before_action :current_user_is_task_user_id, only: [:edit, :update, :destroy] # restrict non-owners

  # GET /tasks
  # GET /tasks.json
  def index # all available task
    @task_check = Task.all
    # need to list only Tasks that is not owned by current_user
    if user_signed_in?
      @my_id = current_user.id
      # All Available task not current_user & checks for accepted_by_user_id == 0
      # query worked only after setting accepted_by_user_id to = 0 from nil
      # Set default field of accepted_by_user_id to 0 within task.rb via after_initialize
      @tasks = Task.where("user_id != ? AND task_status = ? AND accepted_by_user_id = ?", @my_id, "available", 0)
    else
      # All Available task including my tasks : user_signed_in?(false) => index display
      @tasks = Task.where(task_status: "available")
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
      @my_id = current_user.id
      # accept_available_task logic may move into show pages
  end

  # GET /tasks/new
  def new
    @task = current_user.tasks.build # Task.new
    @my_task_status_options = { available: "available", unlist: "unlisted" }
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


  def accept_available_task # logic behind index's accept Tag link
    @tasks = Task.find(params[:id])
    @my_id = current_user.id # enough of these, think to make a set_task params out of this
      # Check that the Task is not owned or currently accepted by current_user
    if @tasks.accepted_by_user_id != @my_id  &&  @tasks.user_id != @my_id
      @tasks.update( { accepted_by_user_id: @my_id, task_status: "processing" } )
      redirect_to @tasks_path, notice: "TAG Accepted" # responding html, includ JSON later
    else
      redirect_to @tasks_path, notice: 'TAG not accepted, try again later'
    end # added @ to tasks_path prior to getting my_accepted_task page working
  end


  def finished_task # mark_accepted_tag_as_finished
    @tasks = Task.find(params[:id])
    @my_id = current_user.id # redundant_5
      # Check that the Task is not owned or currently accepted by current_user
    if @tasks.accepted_by_user_id == @my_id  &&  @tasks.user_id != @my_id # last conditional, why?
      @tasks.update( { task_status: "Finished" } )
      redirect_to my_task_path, notice: "TAG Marked as Finished, Owner will Review prior to Payment"
      # responding html, includ JSON later
    else
      redirect_to my_task_path, notice: 'TAG not marked as Finished, please try again later'
    end # added @ to tasks_path prior to getting my_accepted_task page working
  end


  # Task of current_user which have an accepted_by_id
  def my_task_accepted_by_another_user_id # accepted_by_id, != nil
    @my_id = current_user.id
    # @other_user_id = Task.where(user_id: @my_id, accepted_by_id: != nil) # !empty?) # preset to nil
    @tasks = Task.where(user_id: @my_id, accepted_by_id: any?) # if !empty? doens't work != nil may
    # @tasks = Task.where(user_id: !current_user, accepted_by_user_id: nil, task_status: "available")
  end

  # TAG's accepted_by_current_user # <- old name
  def my_accepted_task
    @my_id = current_user.id # redundant 3
    @tasks = Task.where(accepted_by_user_id: @my_id)
    # We may wish to only list task we are working on and with status processing, and nothing more
    #@tasks = Task.where("user_id != ? AND task_status = ? AND accepted_by_user_id = ?", @my_id, "available", 0)
    @other_user_task_status_options = {finished: "finished", processing: "processing", error_in_tag: "errors in TAG", Return_Tag: "Please_remove_me"}
  end

  # Task of current_user Linked as My-TAG's in application.html.erb
  def my_task
    @my_id = current_user.id # may be redundant4 but will head towards service objects
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
