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

  def company_info
    # data = {"CompanyName"=>"Delhivery","CompanyLogo"=>"/images/companies/delhivery_logo.png","StartedIn"=>"2012","NoOfEmployees"=>"30000","HeadQuarter",}
      data = {"CompanyName"=>"Delhivery", "CompanyLogo"=>"/images/companies/delhivery_logo.png", "StartedIn"=>"2011", "NoOfEmployees"=>"32000", "HeadQuarter"=>"Bangalore", "IndustrySector"=>"Travel Agency", "TechStack"=>"Python,Android,Javascript,Node.js, AngulaJS,ROR,SQL,AWS", "Revenue(M$)"=>"20", "Funding(M$)"=>"130", "WebsiteUrl"=>"delhivery.com", "CEOName"=>"Sahil Barua", "CEO_imageLink"=>nil, "FundingDetail"=>["$85.0 Mn in Series D by Tiger Global Management,$35.0 Mn in Series C by Multiples Alternate Asset Management,$6.0 Mn in Series B by Nexus Venture Partners,$1.5 Mn in Series A by Times Internet"]}
    render :json=>data.to_json
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
