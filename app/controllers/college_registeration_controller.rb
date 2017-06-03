require 'es/campus_sync'
class CollegeRegisterationController < ApplicationController
  layout 'users'
  before_action :user_status
  def index
  end
  def index_back
  end

  def create
    college = params["college_name"]
    params[:current_user_id] = current_user.id
    if Campus.where(:college_name=>college).blank?
        clg_id = CRUD::College::CreateUpdate.new.register_college params
        res = ES::CampusSync.delay.execute(clg_id)
    end    
    redirect_to(:controller=>"dashboard",:action=>"index")
  end


end