class CollegeUser < ApplicationRecord
  belongs_to :college_detail
  belongs_to :user

  def self.create_new_college_user options
  		college_user = CollegeUser.new
  		college_user.create_college_user options
  end

  def create_college_user options
  		self.college_detail_id = options["college_detail_id"]
        self.user_id = options["current_user_id"]
        self.save!
  end
end
