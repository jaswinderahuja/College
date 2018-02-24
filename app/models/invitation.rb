class Invitation < ApplicationRecord
  belongs_to :campus
  belongs_to :user

	validates_presence_of :opening_id,:campus_id
  def  self.send_request(params)
  		inv_sent = Invitation.new
  		inv_sent.campus_id = params[:campus_id]	
  		inv_sent.opening_id = params[:opening_id]	
  		inv_sent.user_id = params[:current_user_id]
  		inv_sent.save!      
  		return inv_sent
  end
end
