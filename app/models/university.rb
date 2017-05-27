class University < ApplicationRecord
	has_many :university_addresses
	has_many :university_users
  has_many :campus_invites, as: :campus_details
  has_many :colleges  

	def self.create_new_university options
      University.transaction do
      	university = University.new
      	university.create_university options
      	return university
      end
	end

	def create_university options
        self.name = options["university_name"]
        self.save!
	end

end
