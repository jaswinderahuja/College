class CampusUser < ApplicationRecord
  belongs_to :campus
  belongs_to :user

  def self.create_new_campus_user options
  		campus_user = CampusUser.new
  		campus_user.create_campus_user options
  end

  def create_campus_user options
  		self.campus_id = options["campus_id"]
      self.user_id = options["current_user_id"]
      self.save!
  end
end
