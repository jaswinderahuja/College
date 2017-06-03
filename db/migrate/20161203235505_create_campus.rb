class CreateCampus< ActiveRecord::Migration[5.0]
  def change
    create_table :campus do |t|
      t.string :college_name,null:false
      t.string :university_name
      t.timestamps
    end
  end
end
