class CreateCollegeUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :college_users do |t|
      t.references :college, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
