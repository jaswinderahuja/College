class CreateContactDetails < ActiveRecord::Migration[5.0]
  def up
    create_table :contact_details,:id=>false do |t|
      t.integer :college_id
      t.string :email_1
      t.string :email_2
      t.string :phone_number1
      t.string :phone_number2
      t.timestamps
    end
  end
  def down
    drop_table :contact_details
  end
end
