class CreateCollegesCourses < ActiveRecord::Migration[5.0]
  def up
    create_table :colleges_courses, :id=>false do |t|
      t.references :college_detail, foreign_key: true      
      # t.integer :college_id
      t.integer :course_id
    end
    add_index :colleges_courses, [:college_detail_id,:course_id],unique: true
  end

  def down
    drop_table :colleges_courses
  end
end
