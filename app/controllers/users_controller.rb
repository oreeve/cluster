class UsersController < ApplicationController

  def show
    @submissions = Submission.where(student_id: current_user)
  end
end
