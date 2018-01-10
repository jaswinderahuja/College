class Users::ProfileManagementController < ApplicationController
	layout "profile_management"
  def index
  	@message = params[:message]
    @error = params[:error]
  end

  def edit_contact_details

  end

  def edit
  		begin
	  		current_user.update_user(params)
	  		redirect_to(:action=>"index",:message=>"Campus information updated successfully.")  			
  		rescue => e
  			puts e
		    redirect_to(:action=>"index",:error=>"OOPS, something went wrong!")
  		end
  end
end
