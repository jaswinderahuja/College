require 'es/elasticsearch_sync'
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
          univ_id = CRUD::College::CreateUpdate.new.register_university params
          puts "it's a univeristy"
          # create delayed job to sync university to elasticsearch
          
        end
    else
      if CollegeDetail.where(:name=>college).blank?
          clg_id = CRUD::College::CreateUpdate.new.register_college params
          res = ES::ElasticsearchSync.delay.execute(clg_id)
      end
    end
    redirect_to(:controller=>"dashboard",:action=>"index")
  end


end