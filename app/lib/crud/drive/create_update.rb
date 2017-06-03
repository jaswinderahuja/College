module CRUD
  module Drive
    class CreateUpdate

    	def get_campus(name)
            college = Campus.where("college_name"=>name).first
            return college if college.present?
    	end

        
    	def college_drive options
    		ApplicationRecord.connection.transaction do
    		  	campus = get_campus(options["college_name"])
                if campus.blank?
                    raise Exception,"University/College Doesn't exists or spelling wrong"
                end
                campus_invite = CampusInvite.new
                campus_invite.campus_id = campus.id
                campus_invite.create_campus_drive options
                campus_invite.id
    		end	
    	end

        def get_departments
            result = Hash.new
            departments = Department.select("id,name")
            departments.each do |dept|
                result[dept.id] = dept.name 
            end
            return result
        end
    	
    end
  end
end


