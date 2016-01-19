class Assignment < ActiveRecord::Base
  mount_uploader :file, AssignmentUploader
  belongs_to :user
end
