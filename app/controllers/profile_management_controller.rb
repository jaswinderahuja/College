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
      params[:user_id] = current_user.id
      params[:country] = "India"
    	CRUD::College::CreateUpdate.new.update_campus(params)
      redirect_to(:action=>"index",:message=>"Campus information updated successfully.")
    rescue => e            
      puts e
      redirect_to(:action=>"index",:error=>"OOPS, something went wrong!")
    end         
  end
end
