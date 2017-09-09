require "#{Rails.root}/app/lib/es/search_engine"
class DashboardController < AuthenticatedController
  layout 'dashboard'
  before_filter :college_registration_exists?
  

  def college_registration_exists?
    puts "=========cool==================="
  	if current_user.campus_users.present?
  	else
  	    redirect_to(:controller=>"college_registeration",:action=>"index") 	
  	end
  end

  def index
  end

  def company_details
    
  end

  def get_companies
        sort_option = params["sort_option"] || "package_upper"
        result = {}
        status = 200
        message = "success"
        error = ""
      begin
        from = 0
        size = 10
        data = ES::SearchEngine.new.initial_load(from,size,sort_option) 
        puts data
      rescue Exception => e
        status = 500
        error = e.message
        message = "OOPS, something went wrong!"
      ensure
        result = { "companies"=>data,"message"=>message,"error"=>error}.to_json    
        render json: result,code: status
      end
  end
end
