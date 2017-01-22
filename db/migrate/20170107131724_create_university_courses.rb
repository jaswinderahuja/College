class CreateUniversityCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :university_courses,:id=>false do |t|
      t.references :university, foreign_key: true
      t.references :course, foreign_key: true
      t.timestamps
    end
  end
end
