class Roster < ActiveRecord::Base
  belongs_to :teacher, class_name: "User"
  belongs_to :student, class_name: "User"

  validates_uniqueness_of :student_id
end
