class College < ApplicationRecord
	has_many :college_users
	belongs_to :universities
end