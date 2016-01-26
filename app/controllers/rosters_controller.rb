class RostersController < ApplicationController
  before_filter :authorize_user!

  def index
    @class = Roster.all.where(teacher_id: current_user.id)
  end

  def new
    @teacher = User.find(current_user.id)
    @roster = Roster.new
  end

  def create
    @teacher = User.find(current_user.id)
    @roster = Roster.new(roster_params)
    @roster.teacher = @teacher
    @roster.student = User.find_by(email: "#{params[:roster][:student]}")

    unless @roster.student.teacher?
      if @roster.save
        flash[:success] = "Student added!"
        redirect_to rosters_path
      else
        create_or_update_failure
      end
    else
      flash[:warning] = "Cannot add a teacher to a class!"
      redirect_to rosters_path
    end
  end

  def update
    @roster = Roster.find(params[:id])
    @roster.teacher = current_user

    if @roster.save
      flash[:success] = "Student added!"
      redirect_to rosters_path
    else
      create_or_update_failure
    end
  end

  def destroy
    @roster = Roster.find(params[:id])
    @roster.destroy
    redirect_to rosters_path
  end

  private

  def roster_params
    params.require(:roster).permit(:teacher_id, :student_id)
  end

  def authorize_user!
    unless current_user && current_user.teacher?
      redirect_to new_user_session_path
    end
  end

  def create_or_update_failure
    flash[:warning] = @roster.errors.full_messages.join(', ')
    render :new
  end
end
