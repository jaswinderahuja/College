class CreateUniversities < ActiveRecord::Migration[5.0]
  def up
    create_table :universities do |t|
      t.string :name, null: false
      t.string :address_id
      t.timestamps
    end
  end

  def down
    drop_table :universities
  end
end
