class CreateCities < ActiveRecord::Migration[5.0]
  def up
    create_table :cities do |t|
      t.string :name, null: false
      t.integer :state_id
      t.timestamps
    end
  end
  def down
    drop_table :cities
  end
end
