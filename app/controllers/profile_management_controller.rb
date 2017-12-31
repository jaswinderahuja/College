class ProfileManagementController < ApplicationController
  def index
    @message = params[:message]
    @error = params[:error]
  end

  def edit
  	puts params
  end

  def edit_campus_and_address    
    begin
      
    	
      redirect_to(:action=>"index",:message=>"Campus information updated successfully.")
    rescue => e      
      redirect_to(:action=>"index",:error=>"OOPS, something went wrong!")
    end         
  end
end
