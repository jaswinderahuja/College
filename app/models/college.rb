class College < ApplicationRecord
	has_many :college_users
	belongs_to :universities

	def self.create_new_college
		
	end
end
