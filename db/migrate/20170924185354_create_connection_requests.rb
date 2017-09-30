class CreateConnectionRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :connection_requests do |t|
      t.references :campus, foreign_key: true
      t.integer :opening_id,  null: false
      t.integer :company_id
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
