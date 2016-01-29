class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.text :body, null: false
      t.belongs_to :student, null: false
      t.belongs_to :assignment, null: false
      t.integer :grade
      t.string :comments
    end
  end
end
