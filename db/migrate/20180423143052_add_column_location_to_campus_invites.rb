class AddColumnLocationToCampusInvites < ActiveRecord::Migration[5.0]
  def change
    add_reference :campus_invites, :city, foreign_key: true, :index=>true
  end
end
