class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :title, null: false
      t.text :instructions
      t.text :teacher_comments
      t.datetime :due_date
      t.belongs_to :user, null: false
      t.string :file
    end
  end
end
