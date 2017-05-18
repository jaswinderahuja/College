module CRUD
  module College
    class CreateUpdate
      #Used to create and update company registration details

      def create_address_detail options
        st = State.find_or_create_by(name: options[:state])
        city = City.find_or_create_by(name: options[:town_city],state_id: st.id)
        pincode = Pincode.find_or_create_by(pincode: options[:pincode],city_id: city.id)
        pincode
      end

      # 4 steps to register univeristy
      # 1. create_new_university
      # 2. create UniversityUser in join for University and User
      # 3. create UniversityContacts
      # 4. create UniversityAddress
      def register_university options
        ApplicationRecord.connection.transaction do
          univ = University.create_new_university options
          options[:university_id] = univ.id
          UniversityUser.create_new_university_user options
          univ_cd = UniversityContactDetail.create_new_university_contact options          
          pin_code = create_address_detail options
          options[:pincode] = pin_code.pincode
          UniversityAddress.create_new_univeristy_address options
        end
      end
    end
  end
end
