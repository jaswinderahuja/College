require "#{Rails.root}/app/lib/es/search_engine"
class DashboardController < AuthenticatedController
  layout 'dashboard'
  before_filter :college_registration_exists?


  def college_registration_exists?
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
           # res = ConnectionRequest.SentRequest(params);
        rescue Exception=>e
            status = 500
            error = e.message
            message = "OOPS, something went wrong!"
        end
        render :json=>{"message": message,"status": status},:status=> status
  end

  def company_info
      response = {:data=>{}}
      # data ={
      #         "2"=>{"company_id": 1 ,"CompanyName"=>"Delhivery", "CompanyLogo"=>"/images/companies/delhivery_logo.png", "StartedIn"=>"2011", "NoOfEmployees"=>"32000", "HeadQuarter"=>{"name"=> "Bangalore"},"tag_line": "Enabling Commerce" ,"IndustrySector"=>"Travel Agency", "TechStack"=>["Python","Android","Javascript","Node.js","AngulaJS","ROR","SQL","AWS"], "Revenue"=>"20 MN", "Funding"=>"130", "WebsiteUrl"=>"https://www.delhivery.com", "CEOName"=>"Sahil Barua", "CEO_imageLink"=>nil, "FundingDetail"=>["$85.0 Mn in Series D by Tiger Global Management","$35.0 Mn in Series C by Multiples Alternate Asset Management","$6.0 Mn in Series B by Nexus Venture Partners","$1.5 Mn in Series A by Times Internet"], "opening_details": {"location": {"name"=>"Delhi"},"no_of_openings": "20","position": "Machine Learning Engineer","CTC": "Best In Industry"  ,"description": "We are seeking a candidate who will participate in all aspects of architecting and developing new and innovative applications. You will have the opportunity to work on cutting edge technology and new product development in an established company that is rapidly growing." }} ,
      #         "1"=>{"company_id": 2 ,"CompanyName"=>"Pramata Knowledge solution pvt ltd", "CompanyLogo"=>"/images/companies/pramata.png", "StartedIn"=>"2011", "NoOfEmployees"=>"200+", "HeadQuarter"=>{"name" => "USA"},"tag_line": "Solving Contracts" , "IndustrySector"=>"Contract Intelligence", "TechStack"=>["Python","Android","Javascript","Node.js","AngulaJS","ROR","SQL","AWS"], "Revenue"=>"10 MN", "Funding"=>"130", "WebsiteUrl"=>"https://www.pramata.com", "CEOName"=>"Praful saklani", "CEO_imageLink"=>nil, "FundingDetail"=>["$85.0 Mn in Series D by Tiger Global Management","$35.0 Mn in Series C by Multiples Alternate Asset Management","$6.0 Mn in Series B by Nexus Venture Partners","$1.5 Mn in Series A by Times Internet"], "opening_details": {"location":  {"name"=>"Bangalore"},"no_of_openings": "2","position": "Contract Analyst","CTC": "3 - 10 LPA"  ,"description": "We are seeking a candidate who will participate in all aspects of architecting and developing new and innovative applications. You will have the opportunity to work on cutting edge technology and new product development in an established company that is rapidly growing." }}
      #       }
      # response = data[params["op_id"].to_i.to_s]
      c_details = Search::CompanyDetail.new(params["op_id"].to_i)
      response[:data] = c_details.search[0]
      render :json=>response.to_json
  end

  def company_details
      @op_id = params["op_id"].to_i
      @campus_id = current_user.campus_users.first.campus_id
      @knocked =  nil #ConnectionRequest.where(:campus_id=>@campus_id,:opening_id=>@op_id).present?
  end

  # def get_companies
  #       sort_option = params["sort_option"] || "package_upper"
  #       result = {}
  #       from = 0
  #       size = 10
  #       if @query.present?
  #           sb = Search::SearchBase.new(query,sort_option)
  #           data = sb.search
  #       else
  #         data = ES::SearchEngine.new.initial_load(from,size,sort_option)
  #       end
  #       result = { "openings"=>data}.to_json
  #       render json: result
  # end

  def search_openings
      sort_option = params["sort_option"]
      location_filter = params["l"].collect(&:downcase) if params["l"].present?
      department_filter = params["d"].collect{|item|  item.downcase.split(" ") }.flatten if params["d"].present?
      query = params["q"]
      from = params["f"] || 0
      data = []
      sb = Search::SearchBase.new(query,from,sort_option,location_filter,department_filter)
      data = sb.search
      render :json=>{"openings"=>data,"message"=>"","error"=>""}
  end

end
