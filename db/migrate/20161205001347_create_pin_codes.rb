class CreatePinCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :pin_codes,:id=>false do |t|
      t.integer :pincode, null: false
      t.references :city, foreign_key: true
      t.timestamps
    end
  end
end
