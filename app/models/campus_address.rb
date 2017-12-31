class CampusAddress < ApplicationRecord
  belongs_to :campus
  validates :pin_code, presence: true
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

	def self.update_campus_address options
		address = CampusAddress.where(:campus_id=>options["campus_id"]).first
				
		address.create_campus_address options
		return address
	end

end
