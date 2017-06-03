class CreateCampusCourses < ActiveRecord::Migration[5.0]
  def up
    create_table :campus_courses, :id=>false do |t|
      t.references :campus, foreign_key: true      
      # t.integer :college_id
      t.integer :course_id
    end
    add_index :campus_courses, [:campus_id,:course_id],unique: true
  end

  def down
    drop_table :campus_courses
  end
end
