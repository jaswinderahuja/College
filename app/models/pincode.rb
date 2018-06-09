class Pincode < ApplicationRecord
	self.primary_key = "pincode"
	belongs_to :city
	has_many :campus_addresses, foreign_key: "pin_code"
end
