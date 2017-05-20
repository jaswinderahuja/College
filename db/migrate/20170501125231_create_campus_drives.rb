class CreateCampusDrives < ActiveRecord::Migration[5.0]
  def change
    create_table :campus_drives do |t|
      t.references :college_detail, foreign_key: true
 	  t.datetime :date_of_drive
 	  t.string :address
 	  t.integer :no_of_students
      t.references :department, foreign_key: true
 	  t.string :hod_email
 	  t.string :coordinator_email_1
 	  t.string :coordinator_email_2
 	  t.string :coordinator_phone_1
 	  t.string :coordinator_phone_2
 	  t.string :description
 	  t.boolean :status
      t.timestamps
    end
  end
end
