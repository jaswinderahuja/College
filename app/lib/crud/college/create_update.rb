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

    end
  end
end
