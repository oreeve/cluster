class Assignment < ActiveRecord::Base
  mount_uploader :file, AssignmentUploader
  belongs_to :user
  has_many :submissions
  has_many :students, through: :submissions

  validates :title, presence: true
  validates :instructions, presence: true
  validates :file, presence: true
  validate :correct_content_type

  private

  def correct_content_type
    if file.content_type != "application/pdf"
      errors.add(:file, "must be a PDF.")
    end
  end
end
