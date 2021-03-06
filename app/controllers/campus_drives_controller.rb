class CampusDrivesController < ApplicationController
  layout 'dashboard'
	
  def create
  	p params
    begin
      drive_id = CRUD::Drive::CreateUpdate.new.college_drive params
      ES::CampusDriveSync.delay.execute(drive_id)
    rescue Exception => e
      puts e
    end
    redirect_to(:controller=>"dashboard",:action=>"index")  
  end

  def index
  end

  def get_departments
    status = 200
    message = "success"
    error = ""
    begin
    	hash = {}
        hash = CRUD::Drive::CreateUpdate.new.get_departments
    rescue Exception=>e
        status = 500
        error = e.message
        message = "OOPS, something went wrong!"
    ensure
	    result = { "departments"=>hash,"message"=>message,"error"=>error}.to_json    
      	render json: result,code: status
    end
  end

  def get_cities
    status, message, error = 200, "success", ""
    data = []
    begin
      data = CRUD::Drive::CreateUpdate.new.get_cities
    rescue Exception=>e
      status = 500
      error = e.message
      message = "OOPS, something went wrong!"
    end
    result = { "cities"=>data,"message"=>message,"error"=>error}.to_json
    render json: result,code: status
  end

end
