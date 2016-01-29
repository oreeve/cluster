class SubmissionsController < ApplicationController
  def index
    if current_user.teacher?
      @assignment = Assignment.find(params[:assignment_id])
    else
      @submission = Submission.where(student_id: current_user.id).first
    end
  end

  def show
    @submission = Submission.find(params[:id])
  end

  def new
    @assignment = Assignment.find(params[:id])
    @submission = Submission.new
  end

  def create
    @student = User.find(current_user.id)
    @assignment = Assignment.find(params[:assignment_id])
    @submission = Submission.new(sub_params)
    @submission.student = @student
    @submission.assignment = @assignment

    if @submission.save
      flash[:success] = "Submission submitted!"
      redirect_to assignment_path(@assignment)
    else
      create_or_update_failure
    end
  end

  def edit
    @assignment = Assignment.find(params[:id])
    @submission = Submission.where(student_id: current_user.id, assignment_id: @assignment.id).first
  end

  def update
    @assignment = Assignment.find(params[:assignment_id])

    if current_user.teacher?
      @submission = Submission.where(assignment_id: @assignment.id, student_id: params[:student_id]).first
      if @submission.update(sub_params)
        flash[:success] = "Submission graded!"
        redirect_to assignment_submissions_path(@assignment)
      else
        create_or_update_failure
      end
    else
      @student = User.find(current_user.id)
      @submission = Submission.where(student_id: @student.id, assignment_id: @assignment.id).first
      if @submission.update(sub_params)
        flash[:success] = "Submission updated!"
        redirect_to assignment_path(@assignment)
      else
        create_or_update_failure
      end
    end
  end

  def destroy
    @submission = Submission.find(params[:id])
    if @submission.destroy
      flash[:success] = "Submission deleted!"
      redirect_to submissions_path
    end
  end

  private

  def sub_params
    params.require(:submission).permit(:assignment_id, :student_id, :body, :grade, :comments)
  end

  def authorize_user!
    unless current_user && current_user.teacher?
      redirect_to new_user_session_path
    end
  end

  def create_or_update_failure
    flash[:warning] = @submission.errors.full_messages.join(', ')
    render :new
  end
end
