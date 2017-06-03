class CreateAppExceptions < ActiveRecord::Migration[5.0]
  def up
    create_table :app_exceptions do |t|
      t.string :name
      t.text :message
      t.text :stacktrace
      t.string :created_by		
      t.timestamps
    end
  end

  def down
  	drop_table :app_exceptions
  end
end
