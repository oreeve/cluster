class Submission < ActiveRecord::Base
  belongs_to :student, class_name: "User"
  belongs_to :assignment
  has_one :teacher, class_name: "User", through: :assignment

  validates_uniqueness_of :student_id, scope: :assignment_id
  validates :body, presence: true

  def past_due?
    created_at > assignment.due_date
  end
end
