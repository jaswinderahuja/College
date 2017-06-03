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
      def register_university options
        ApplicationRecord.connection.transaction do
          univ = University.create_new_university options
          options[:university_id] = univ.id
          UniversityUser.create_new_university_user options
          univ_cd = UniversityContactDetail.create_new_university_contact options          
          pin_code = create_address_detail options
          options[:pincode] = pin_code.pincode
          UniversityAddress.create_new_univeristy_address options
          return univ.id
        end
      end

      def register_college options
          ApplicationRecord.connection.transaction do
             university = University.find_by_name(options["university_name"])
             if !university.present?
                university = University.create_new_university options
             end
             options[:university_id] = university.id
             p options
             clg = CollegeDetail.create_new_college options
             options[:college_detail_id] = clg.id
             CollegeUser.create_new_college_user options
             clg_cd = CollegeContactDetail.create_new_college_contact options
             pin_code = create_address_detail options
             options[:pincode] = pin_code.pincode
             CollegeAddress.create_new_college_address options
             return clg.id
          end
      end

    end
  end
end
