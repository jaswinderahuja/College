class CreateReceivedRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :received_requests do |t|
      t.references :campus_invites, foreign_key: true
      t.integer :company_id,  null: false
      t.integer :user_email, null: false
      t.boolean :accepted, default: false
      t.timestamps
    end
  end
end
