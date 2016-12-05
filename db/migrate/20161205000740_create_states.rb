class CreateStates < ActiveRecord::Migration[5.0]
  def change
    create_table :states do |t|
      t.string :name, null: false
      t.references :country, foreign_key: true

      t.timestamps
    end
  end
end
