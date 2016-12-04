class CreateColleges < ActiveRecord::Migration[5.0]
  def up
    create_table :colleges do |t|
      t.string :name, null:false
      t.integer :address_id
      t.integer :is_affliated_to_id
      t.timestamps
    end
  end

  def down
    drop_table :colleges
  end
end
