class CreateCollegeContactDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :college_contact_details, :id=>false do |t|
      t.string :email_1
      t.string :email_2
      t.string :phone_number_1
      t.string :phone_number_2      
      t.string :landline_number      
      t.references :college_detail, foreign_key: true

      t.timestamps
    end
  end
end
