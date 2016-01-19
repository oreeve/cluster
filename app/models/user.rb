class User < ActiveRecord::Base
  has_many :assignments

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
