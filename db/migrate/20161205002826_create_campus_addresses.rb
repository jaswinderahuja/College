class CreateCampusAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :campus_addresses do |t|
      # t.string :landline_number
      t.string :address1
      t.string :address2
      t.integer :pin_code      
      t.references :campus, foreign_key: true
      t.timestamps
    end
  end
end
