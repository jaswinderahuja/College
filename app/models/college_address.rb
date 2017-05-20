class CollegeAddress < ApplicationRecord
  belongs_to :college_detail

  def self.create_new_college_address options		
		address = CollegeAddress.new
		address.create_college_address options
	end 

	def create_college_address options
      	self.address1 = options["address_line_1"]
      	self.address2 = options["address_line_2"]
      	self.college_detail_id = options["college_detail_id"]     	
      	self.pin_code = options["pincode"]
	    self.save!      	
	end
end
