class CreateUserHelps < ActiveRecord::Migration[5.0]
  def change
    create_table :user_helps do |t|
      t.references :user, foreign_key: true
      t.string :email
      t.string :contact_number
      t.string :ticket_type
      t.string :status
      t.timestamps
    end
  end
end
