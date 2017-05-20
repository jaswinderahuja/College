class CollegeRegisterationController < ApplicationController
  layout 'users'
  before_action :user_status

  
  def index
  end
  def index_back
  end

  def create
    university = params["university_name"]
    college = params["college_name"]
    params[:current_user_id] = current_user.id
    puts "==================================================="
    p params    
    puts "==================================================="
    if college == university
        if University.find_by_name(university).blank?          
          CRUD::College::CreateUpdate.new.register_university params
          puts "it's a univeristy"
        end
    else
      if CollegeDetail.where(:name=>college).blank?
          CRUD::College::CreateUpdate.new.register_college params
      end
    end
    redirect_to(:controller=>"dashboard",:action=>"index")
  end


end