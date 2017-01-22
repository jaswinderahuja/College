class University < ApplicationRecord
	has_many :university_addresses
	has_many :university_users
end
