class AssignmentsController < ApplicationController
  before_filter :authorize_user!, except: [:index, :show]

  def index
    @teacher = User.find(current_user)
    @assignments = Assignment.all.where(user_id: @teacher.id)
  end

  def show
    @assignment = Assignment.find(params[:id])
    @document = WatsonApi.new(@assignment.file.path)
  end

  def new
    @teacher = User.find(current_user)
    @assignment = Assignment.new
  end

  def create
    @teacher = User.find(current_user)
    @assignment = Assignment.new(assignment_params)
    @assignment.user = @teacher

    if @assignment.save
      flash[:success] = "Assignment added successfully!"
      redirect_to assignment_path(@assignment)
    else
      create_or_update_failure
    end
  end

  def edit
    @assignment = Assignment.find(params[:id])
  end

  def update
    @assignment = Assignment.find(params[:id])
    @assignment.user = current_user

    if @assignment.update(assignment_params)
      flash[:success] = "Assignment updated successfully!"
      redirect_to assignment_path(@assignment)
    else
      create_or_update_failure
    end
  end

  def destroy
    @assignment = Assignment.find(params[:id])
    @assignment.destroy
    redirect_to assignments_path
  end

  private

  def assignment_params
    params.require(:assignment).permit(
                   :title,
                   :instructions,
                   :teacher_comments,
                   :due_date,
                   :user_id,
                   :file
                   )
  end

  def authorize_user!
    unless current_user && current_user.teacher?
      redirect_to new_user_session_path
    end
  end

  def create_or_update_failure
    flash[:warning] = @assignment.errors.full_messages.join(', ')
    render :new
  end
end
