class UniversityUser < ApplicationRecord
  belongs_to :university
  belongs_to :user

  def self.create_new_university_user(options)
        univ_user = UniversityUser.new
        univ_user.create_university_user options
        return univ_user
  end

  def create_university_user options
        self.university_id = options["university_id"]
        self.user_id = options["current_user_id"]
        self.save!  	
  end
end
