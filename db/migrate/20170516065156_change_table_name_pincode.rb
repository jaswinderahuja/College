class ChangeTableNamePincode < ActiveRecord::Migration[5.0]
  def change
  	rename_table :pin_codes, :pincodes
  end
end
