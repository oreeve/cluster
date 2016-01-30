class SubmissionsController < ApplicationController
  before_filter :authorize_user!, only: [:index]
  def index
    @assignment = Assignment.find(params[:assignment_id])
    @submissions = @assignment.submissions
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
      flash[:success] = "Submission added!"
      redirect_to assignment_path(@assignment)
    else
      flash[:warning] = @submission.errors.full_messages.join(', ')
      redirect_to assignment_path(@assignment)
    end
  end

  def edit
    @assignment = Assignment.find(params[:assignment_id])
    @submission = Submission.find(params[:id])
  end

  def update
    @assignment = Assignment.find(params[:assignment_id])
    @submission = Submission.find(params[:id])

    if @submission.update(sub_params)
      flash[:success] = "Submission graded!"
      redirect_to assignment_submissions_path(@assignment)
    else
      create_or_update_failure
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
      redirect_to root_path
      flash[:notice] = "Only teachers can view submissions!"
    end
  end

  def create_or_update_failure
    flash[:warning] = @submission.errors.full_messages.join(', ')
    render :new
  end
end
