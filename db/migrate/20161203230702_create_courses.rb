class CreateCourses < ActiveRecord::Migration[5.0]
  def up
    create_table :courses do |t|
      t.string :name
      t.integer :department_id
      t.timestamps
    end
  end

  def down
    drop_table :courses
  end
end
