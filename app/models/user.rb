class User < ActiveRecord::Base
  has_many :assignments
  has_many :classes, class_name: "Roster", foreign_key: "teacher_id"
  has_one :in_class, class_name: "Roster", foreign_key: "student_id"

  validates :role, presence: true, inclusion: { in: ["Teacher", "Student"] }
  validates :first_name, presence: true
  validates :last_name, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  def teacher?
    role == "Teacher"
  end
end
