class CreateColleges < ActiveRecord::Migration[5.0]
  def change
    create_table :colleges do |t|
      t.string :name,null:false
      t.references :college_address, foreign_key: true
      t.integer :is_affliated_to_id
      t.timestamps
    end
  end
end
