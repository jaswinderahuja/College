module CRUD
  module College
    class CreateUpdate
      #Used to create and update company registration details      

      def create_address_detail options
        country = Country.find_or_create_by(name: options[:country])
        st = State.find_or_create_by(name: options[:state],country_id: country.id)
        city = City.find_or_create_by(name: options[:town_city],state_id: st.id)
        pincode = Pincode.find_or_create_by(pincode: options[:pincode],city_id: city.id)
        pincode
      end

      # 4 steps to register univeristy
      # 1. create_new_university
      # 2. create UniversityUser in join for University and User
      # 3. create UniversityContacts
      # 4. create UniversityAddress
      def register_college options
          ApplicationRecord.connection.transaction do
             campus = Campus.create_new_campus options
             options[:campus_id] = campus.id
             CampusUser.create_new_campus_user options
             clg_cd = CampusContactDetail.create_new_campus_contact options
             pin_code = create_address_detail options
             options[:pincode] = pin_code.pincode
             CampusAddress.create_new_campus_address options
             return campus.id
          end
      end

      
      def update_campus options
          Campus.transaction do 
            campus = Campus.where(:college_name=>options[:college_name]).first            
            if !campus.present?
              campus = Campus.create_new_campus options              
              #  update the campus_id in campususer and campus_id in campus_addresses
              cu = CampusUser.where(:user_id=>options[:user_id]).first
              old_campus_id = cu.campus_id
              cu.campus_id = campus.id              
              cu.save!              
              address = CampusAddress.where(:campus_id=>old_campus_id).first
              address.campus_id = campus.id
              address.save!              
              contact_detail = CampusContactDetail.where(:campus_id=>old_campus_id).first
              contact_detail.campus_id = campus.id
              contact_detail.save!
            end            
              campus.university_name = options[:university_name] 
              campus.save!            
              options["campus_id"] = campus.id
              pin = create_address_detail options            
              options["pincode"] = pin.pincode
              CampusAddress.update_campus_address options                
            return campus.id
          end
      end

    end
  end
end
