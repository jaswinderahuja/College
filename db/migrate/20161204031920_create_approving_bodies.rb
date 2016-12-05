class CreateApprovingBodies < ActiveRecord::Migration[5.0]
  def change
    create_table :approving_bodies do |t|
      t.string :name
      t.timestamps
    end
  end
end
