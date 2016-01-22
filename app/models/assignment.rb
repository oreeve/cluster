class Assignment < ActiveRecord::Base
  mount_uploader :file, AssignmentUploader
  belongs_to :user

  validates :title, presence: true
  validates :instructions, presence: true
  validates :file, presence: true
end
