class CreateCollegeDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :college_details do |t|
      t.string :name,null:false
      t.integer :is_affliated_to_id
      t.timestamps
    end
  end
end
