class CampusAddress < ApplicationRecord
  belongs_to :campus

  def self.create_new_campus_address options		
		address = CampusAddress.new
		address.create_campus_address options
	end 

	def create_campus_address options
      	self.address1 = options["address_line_1"]
      	self.address2 = options["address_line_2"]
      	self.campus_id = options["campus_id"]     	
      	self.pin_code = options["pincode"]
	    self.save!      	
	end
end
