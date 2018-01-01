module CRUD
  module College
    class CampusContact
    	def initialize options
    		@campus_id = options[:campus_id]    		
      		@email_1 = options[:email_id_1]
      		@email_2 = options[:email_id_2]
      		@phone_number_1 = options[:phone_1]
      		@phone_number_2 = options[:phone_2]
      		@landline_number = options[:landline_no]
    		@campus_contact_detail = CampusContactDetail.where(:campus_id=>@campus_id).first
    	end

    	def update    		
    		CampusContactDetail.transaction do
		      @campus_contact_detail.email_1 = @email_1
		      @campus_contact_detail.email_2 = @email_2
		      @campus_contact_detail.phone_number_1 = @phone_number_1
		      @campus_contact_detail.phone_number_2 = @phone_number_2
		      @campus_contact_detail.landline_number = @landline_number
		      @campus_contact_detail.save!
		  	end
    	end

    end
  end
end

