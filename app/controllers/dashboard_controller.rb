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


  def create_interest
        status = 200
        message = "success"
        error = ""
        begin
           params[:current_user] = current_user.id           
           res = ConnectionRequest.SentRequest(params);
        rescue Exception=>e
            status = 500
            error = e.message
            message = "OOPS, something went wrong!"
        end
        render :json=>{"message": message,"status": status},:status=> status 
  end

  def company_info
      data ={
              "2"=>{"company_id": 1 ,"CompanyName"=>"Delhivery", "CompanyLogo"=>"/images/companies/delhivery_logo.png", "StartedIn"=>"2011", "NoOfEmployees"=>"32000", "HeadQuarter"=>"Bangalore","tag_line": "Enabling Commerce" ,"IndustrySector"=>"Travel Agency", "TechStack"=>["Python","Android","Javascript","Node.js","AngulaJS","ROR","SQL","AWS"], "Revenue(M$)"=>"20", "Funding(M$)"=>"130", "WebsiteUrl"=>"https://www.delhivery.com", "CEOName"=>"Sahil Barua", "CEO_imageLink"=>nil, "FundingDetail"=>["$85.0 Mn in Series D by Tiger Global Management","$35.0 Mn in Series C by Multiples Alternate Asset Management","$6.0 Mn in Series B by Nexus Venture Partners","$1.5 Mn in Series A by Times Internet"], "opening_details": {"location": "Delhi","no_of_openings": "20","position": "Machine Learning Engineer","CTC": "Best In Industry"  ,"description": "We are seeking a candidate who will participate in all aspects of architecting and developing new and innovative applications. You will have the opportunity to work on cutting edge technology and new product development in an established company that is rapidly growing." }} , 
              "1"=>{"company_id": 2 ,"CompanyName"=>"Pramata Knowledge solution pvt ltd", "CompanyLogo"=>"/images/companies/pramata.png", "StartedIn"=>"2011", "NoOfEmployees"=>"200+", "HeadQuarter"=>"USA","tag_line": "Solving Contracts" , "IndustrySector"=>"Contract Intelligence", "TechStack"=>["Python","Android","Javascript","Node.js","AngulaJS","ROR","SQL","AWS"], "Revenue(M$)"=>"20", "Funding(M$)"=>"130", "WebsiteUrl"=>"https://www.pramata.com", "CEOName"=>"Praful saklani", "CEO_imageLink"=>nil, "FundingDetail"=>["$85.0 Mn in Series D by Tiger Global Management","$35.0 Mn in Series C by Multiples Alternate Asset Management","$6.0 Mn in Series B by Nexus Venture Partners","$1.5 Mn in Series A by Times Internet"], "opening_details": {"location": "Bangalore","no_of_openings": "2","position": "Contract Analyst","CTC": "3 - 10 LPA"  ,"description": "We are seeking a candidate who will participate in all aspects of architecting and developing new and innovative applications. You will have the opportunity to work on cutting edge technology and new product development in an established company that is rapidly growing." }}
            }
      response = data[params["op_id"].to_i.to_s]  
      render :json=>response.to_json
  end

  def company_details
      @op_id = params["op_id"].to_i
      @campus_id = current_user.campus_users.first.campus_id
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
