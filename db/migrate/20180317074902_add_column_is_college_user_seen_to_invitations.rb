class AddColumnIsCollegeUserSeenToInvitations < ActiveRecord::Migration[5.0]
  def change
  	add_column :invitations, :is_college_user_seen, :boolean,:default=>false
  	add_column :invitations, :is_company_user_seen, :boolean,:default=>false
  end
end
