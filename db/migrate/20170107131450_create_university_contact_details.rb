class CreateUniversityContactDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :university_contact_details,:id=>false do |t|
      t.references :university, foreign_key: true
      t.string :email_1
      t.string :email_2
      t.string :phone_number_1
      t.string :phone_number_2
      t.timestamps
    end
  end
end
