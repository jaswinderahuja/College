class UniversityAddress < ApplicationRecord
  belongs_to :university
  # validates_presence_of :university_id

	def self.create_new_univeristy_address options		
		address = UniversityAddress.new
		address.create_university_address options
		return address
	end 

	def create_university_address options
      	self.address1 = options["address_line_1"]
      	self.address2 = options["address_line_2"]
      	self.university_id = options["university_id"]     	
      	self.pin_code = options["pin_code"]
	    self.save!      	
	end


end
