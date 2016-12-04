class CreateStates < ActiveRecord::Migration[5.0]
  def up
    create_table :states do |t|
      t.string :name, null: false
      t.integer :country_id
      t.timestamps
    end
  end

  def down
    drop_table :states
  end
end
