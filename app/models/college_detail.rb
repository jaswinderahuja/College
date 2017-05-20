class CollegeDetail < ApplicationRecord
	has_many :college_users
	belongs_to :university , :foreign_key => 'is_affliated_to_id'

	def self.create_new_college options
		college = CollegeDetail.new
		college.create_college options		
		return college
	end

	def create_college options
		self.name = options["college_name"]
        self.is_affliated_to_id = options["university_id"]
        self.save!		
	end
end
