class UserTicket < ApplicationRecord
  self.table_name = "user_helps"
  belongs_to :user

  def self.create_support_ticket(options)
  		ticket = UserTicket.new
  		ticket.user_id = options[:user_id]
  		ticket.email =options[:email]
  		ticket.contact_number =options[:phone_number]
  		ticket.ticket_type ="Contact me"
  		ticket.status ="Pending"
  		ticket.save!
  		return ticket
  end
end
