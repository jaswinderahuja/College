class ReceivedRequest < ApplicationRecord
  belongs_to :campus_invites

  	def self.SentRequest options
		# connection_request = ConnectionRequest.create(:campus_id=>options[:campus_id],:opening_id=>options[:opening_id],:company_id=>options[:company_id],:user_id=>options[:current_user])
	end  
end
