class ProfileManagementController < ApplicationController
  def index
  end

  def edit
  	puts params
  	redirect_to(:action=>"index",:message=>"cool")
  end

  def edit_company_info
  	
  end
end
