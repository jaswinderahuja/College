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
           params[:current_user_id] = current_user.id           
           res = Invitation.send_request(params)                      
        rescue Exception=>e
            status = 500            
            error = e.message
            message = "OOPS, something went wrong!"
        end
        render :json=>{"message": message,"status": status,"error"=>error},:status=> status
  end

  def company_info
      response = {:data=>{}}     
      c_details = Search::CompanyDetail.new(params["op_id"].to_i)
      response[:data] = c_details.search[0]
      render :json=>response.to_json
  end

  def company_details
      @op_id = params["op_id"].to_i
      @responded = params[:accepted].present?
      @campus_id = current_user.campus_users.first.campus_id
      @knocked =  Invitation.where(:campus_id=>@campus_id,:opening_id=>@op_id).present?
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

  def cities
    city_obj = List::City.new
    cities = city_obj.search
    response = {:data=>cities}
    render :json=>response.to_json
  end

  def positions
      pos_obj = List::Position.new
      position = pos_obj.search
      response = {:data=>position}
      render :json=>response.to_json
  end
end
