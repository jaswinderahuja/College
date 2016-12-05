class CreateCountries < ActiveRecord::Migration[5.0]
  def up
    create_table :countries do |t|
      t.string :shortname, null: false
      t.string :name, null: false
      t.timestamps
    end
  end
  def down
    drop_table :countries
  end
end
