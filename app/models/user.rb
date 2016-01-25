class User < ActiveRecord::Base
  has_many :assignments
  belongs_to :teaches_class, class_name: "Class", foreign_key: "teacher_id"
  belongs_to :in_class, class_name: "Class", foreign_key: "student_id"

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
