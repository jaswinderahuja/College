module ProfileManagementHelper
	def campus_info
		campus, address = nil, nil
		if current_user.present?
		  campus = CampusUser.where(:user_id=>current_user.id).first.campus
		  address = campus.campus_address
		end
		return [campus,address]
	end

	def city_state(pincode)
		rows = ActiveRecord::Base.connection.select_rows("select c.name,s.name from pincodes p 
			inner join cities c on p.city_id=c.id 
			inner join states s on c.state_id=s.id where p.pincode=#{pincode}").first
	end

	def contact_details
		contact_info = nil
		if current_user.present?
		  campus = CampusUser.where(:user_id=>current_user.id).first.campus
		  contact_info = campus.campus_contact_detail
		end
		return contact_info
	end
end
