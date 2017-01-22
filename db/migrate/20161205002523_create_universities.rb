class CreateUniversities < ActiveRecord::Migration[5.0]
  def change
    create_table :universities do |t|
      t.string :name,null:false
      # t.references :university_address, foreign_key: true
      t.timestamps
    end
  end
end
