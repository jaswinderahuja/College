class CreateCampusUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :campus_users do |t|      
      t.references :campus, foreign_key: true      
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
