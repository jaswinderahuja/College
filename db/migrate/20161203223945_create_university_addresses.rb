class CreateUniversityAddresses < ActiveRecord::Migration[5.0]
  def up
    create_table :university_addresses do |t|
      t.string :landline_number
      t.string :address1
      t.string :address2
      t.integer :pin_code
      t.timestamps
    end
  end
  def down
    drop_table :university_addresses
  end
end
