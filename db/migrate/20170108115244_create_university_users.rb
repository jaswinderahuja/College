class CreateUniversityUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :university_users do |t|
      t.references :university, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
