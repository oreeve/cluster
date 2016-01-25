class CreateClasses < ActiveRecord::Migration
  def change
    create_table :classes do |t|
      t.belongs_to :teacher
      t.belongs_to :student
    end
  end
end
