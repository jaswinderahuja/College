class CreateInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :invitations do |t|
      t.references :campus, foreign_key: true
      t.integer :opening_id
      t.references :user, foreign_key: true
      t.boolean :accepted

      t.timestamps
    end
  end
end
