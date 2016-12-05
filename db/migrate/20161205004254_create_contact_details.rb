class CreateContactDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :contact_details, :id=>false do |t|
      t.string :email_1
      t.string :email_2
      t.string :phone_number_1
      t.string :phone_number_2
      t.references :college, foreign_key: true

      t.timestamps
    end
  end
end
