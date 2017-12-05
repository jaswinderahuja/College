class Campus < ApplicationRecord
	has_many :campus_users
	has_many :campus_invites 
	has_many :invitations 

	def self.create_new_campus options
		campus = Campus.new
		campus.create_campus options		
		return campus
	end

	def create_campus options
		self.college_name = options["college_name"]
        self.university_name = options["university_name"]
        self.save!		
	end
end
