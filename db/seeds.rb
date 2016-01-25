# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

teacher = User.create!(
  first_name: "Olivia",
  last_name: "Reeve",
  email: 'oereeve@gmail.com',
  role: 'Teacher',
  password: 'testtest',
  password_confirmation: 'testtest'
)

teacher2 = User.create!(
  first_name: "Ophelia",
  last_name: "McAllister",
  email: 'teacher@test.com',
  role: 'Teacher',
  password: 'testtest',
  password_confirmation: 'testtest'
)

student = User.create!(
  first_name: "Andrew",
  last_name: "Clark",
  email: 'aclarkdev@gmail.com',
  role: 'Student',
  password: 'testtest',
  password_confirmation: 'testtest'
)

student2 = User.create!(
  first_name: "John",
  last_name: "Smith",
  email: 'test@test.com',
  role: 'Student',
  password: 'testtest',
  password_confirmation: 'testtest'
)

assign = Assignment.create!(
  title: "Assignment of Awesome!",
  instructions: "Please answer the following questions.",
  teacher_comments: "This is a terrible assignment...",
  due_date: Time.now,
  user_id: teacher.id,
  file: File.new("#{Rails.root}/spec/support/PDFs/sample1.pdf")
)

class1 = Class.create!(
  student_id: student.id,
  teacher_id: teacher.id
)
