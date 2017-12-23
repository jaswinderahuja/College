class UserHelpController < ApplicationController
  def index
    @message = params[:message]
    @error = params[:error]
  end
  def create
  	begin  		
	  	params[:user_id] = current_user.id
	  	ticket = UserTicket.create_support_ticket(params)
	  	redirect_to(:controller=>"user_help",:action=>"index",:message=>"Request Submitted successfully!")
  	rescue =>e
  		p e
  		redirect_to(:controller=>"user_help",:action=>"index",:error=>"OOPS something went wrong, Please try again later!!")
  	end
  end
end
