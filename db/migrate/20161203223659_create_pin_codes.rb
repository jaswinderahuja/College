class CreatePinCodes < ActiveRecord::Migration[5.0]
  def up
    create_table :pin_codes, :id=>false  do |t|
      t.integer :pin_code, null: false
      t.integer :city_id
      t.timestamps
    end
  end

  def down
    drop_table :pin_codes
  end
end
