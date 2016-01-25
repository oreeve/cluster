class CreateRosters < ActiveRecord::Migration
  def change
    create_table :rosters do |t|
      t.belongs_to :teacher, null: false
      t.belongs_to :student, null: false
    end
  end
end
