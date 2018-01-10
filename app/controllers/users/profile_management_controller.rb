class Users::ProfileManagementController < ApplicationController
	layout "profile_management"
  def index
  	@message = params[:message]
    @error = params[:error]
  end

  def edit_social_connect
      begin
        current_user.update_social_connect(params)
        redirect_to(:action=>"index",:message=>"Campus information updated successfully.")        
      rescue => e
        puts e
        redirect_to(:action=>"index",:error=>"OOPS, something went wrong!")
      end
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
