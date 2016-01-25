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

    if @roster.save
      flash[:success] = "Class created!"
      redirect_to @roster
    else
      create_or_update_failure
    end
  end

  # def edit
  #   @roster = Roster.
  # end

  private

  def roster_params
    params.require(:roster).permit(:teacher_id, student_id)
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
