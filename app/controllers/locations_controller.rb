class LocationsController < ApplicationController

  def countries
    begin
      country_list = Country.find_by_sql("select id,name from countries")
      result = []
      country_list.each do |c|
        result << {:id=>c.id,:value=>c.name}
      end
      render :json=>{:countries=>result}.to_json
    rescue Exceptin =>e
      render :json=>{:error=>"Exception Occured"}.to_json ,:status=>500
    end
  end

  def states
    country_id = params[:country_id]
    begin
      states_list = State.find_by_sql(["select id,name from states where country_id=?",country_id])
      result = []
      states_list.each do |c|
      result << {:id=>c.id,:value=>c.name}
      end
      render :json=>{"states"=>result}.to_json
    rescue Exception =>e
      render :json=>{:error=>"Exception Occured"}.to_json ,:status=>500
    end
  end

  def cities
    state_id = params[:state_id]
    begin
      cities_list = State.find_by_sql(["select id,name from cities where state_id=?",state_id])
      result = []
      cities_list.each do |c|
        result << {:id=>c.id,:value=>c.name}
      end
      render :json=>{"cities"=>result}.to_json
    rescue Exception =>e
      render :json=>{:error=>"Exception Occured"}.to_json ,:status=>500
    end
  end


end
