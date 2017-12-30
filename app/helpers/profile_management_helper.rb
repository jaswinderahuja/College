module ProfileManagementHelper
	def campus_info
		campus = CampusUser.where(:user_id=>current_user.id).first.campus
		address = campus.campus_address
		return [campus,address]
	end

	def city_state(pincode)
		rows = ActiveRecord::Base.connection.select_rows("select c.name,s.name from pincodes p 
			inner join cities c on p.city_id=c.id 
			inner join states s on c.state_id=s.id where p.pincode=#{pincode}").first
	end
end
