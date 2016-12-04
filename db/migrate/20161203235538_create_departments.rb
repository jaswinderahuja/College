class CreateDepartments < ActiveRecord::Migration[5.0]
  def up
    create_table :departments do |t|
      t.string :name , null: false
      t.timestamps
    end
  end
  def down
    drop_table :departments
  end
end
