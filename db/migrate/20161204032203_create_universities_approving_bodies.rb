class CreateUniversitiesApprovingBodies < ActiveRecord::Migration[5.0]
  def up
    create_table :universities_approving_bodies,:id=>false do |t|
      t.integer :university_id
      t.integer :approving_body_id
    end
  end

  def down
    drop_table :universities_approving_bodies
  end
end
