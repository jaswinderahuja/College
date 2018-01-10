class AddSocialConnectColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :facebook_link, :string
  	add_column :users, :linkedin_link, :string
  	add_column :users, :twitter_link, :string
  end
end
