class CreateCollegeAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :college_addresses do |t|
      t.string :landline_number
      t.string :address1
      t.string :address2
      t.integer :pin_code
      t.references :city,:foreign_key=>true
      t.references :state,:foreign_key=>true
      t.references :country,:foreign_key=>true
      t.references :college, foreign_key: true
      t.timestamps
    end
  end
end
