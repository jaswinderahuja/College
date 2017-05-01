class CollegeRegisterationController < ApplicationController
  layout 'users'
  before_action :user_status

  
  def index
  end
  def index_back
  end
  def create
    university = params["university"]
    college = params["college"]
    country_id = params["country"]
    if college == university
        if University.find_by_name(university).blank?
          save_university(params)
          puts "it's a univeristy"
        end
    else
      if College.where(:name=>college).blank?
        save_college(params)
      end
    end
    redirect_to(:controller=>"dashboard",:action=>"index")
  end


  def save_college(params)
      College.transaction do
        university = University.find_by_name(params["university"])
        if !university.present? 
            university = University.new
            university.name = params["university"]
            university.save!
        end
        college = College.new 
        college.name = params["college"]
        college.is_affliated_to_id = university.id
        college.save!
        
        college_user = CollegeUser.new
        college_user.college_id = college.id
        college_user.user_id = current_user.id
        college_user.save!


        college_address_hash = {}
        college_address_hash["landline"] = params["landline"]
        college_address_hash["address_line1"] = params["address_line1"]
        college_address_hash["address_line2"] = params["address_line2"]
        college_address_hash["city"] = params["city"]
        college_address_hash["state"] = params["state"]
        college_address_hash["country"] = params["country"]
        college_address_hash["pin_code"] = params["code"]
        college_address_hash["college_id"] = college.id

        save_college_address(college_address_hash)

        # save university contact details
        college_contact_detail = {}
        college_contact_detail["university_id"] = university.id
        college_contact_detail["email1"] = params["email1"]
        college_contact_detail["email2"] = params["email2"]
        college_contact_detail["phone1"] = params["phone1"]
        college_contact_detail["phone2"] = params["phone2"]
        save_college_contact(college_contact_detail)
      end    
  end

  def save_college_address(params)
      country_id, state_id, city_id,pin_code = save_country_state_city_pin(params["country"],params["state"],params["city"],params["pin_code"])
      college_address = CollegeAddress.new
      college_address.landline_number = params["landline"]
      college_address.address1 = params["address_line1"]
      college_address.address2 = params["address_line2"]
      college_address.college_id = params["university_id"]
      college_address.country_id = country_id
      college_address.state_id = state_id
      college_address.city_id = city_id
      college_address.pin_code = pin_code
      college_address.save!
      return college_address.id
  end

  def save_college_contact(params)
      college_contact = CollegeContactDetail.new
      college_contact.college_id = params["university_id"]
      college_contact.email_1 = params["email1"]
      college_contact.email_2 = params["email2"]
      college_contact.phone_number_1 = params["phone1"]
      college_contact.phone_number_2 = params["phone2"]
      college_contact.save!
  end

  def save_country_state_city_pin(country_name,state_name,city_name,pcode)
      country = Country.find_by_name(country_name)
      state = State.find_by_name(state_name)
      city = City.find_by_name(city_name)
      pin_code = PinCode.find_by_pin_code(pcode) 
      
      if country.nil? 
        country = Country.create(:name=>country_name)
      end

      if state.nil?
         state = State.create(:name=>state_name,:country_id=>country.id)
      end

      if city.nil?
         city = City.create(:name=>city_name,:state_id=>state.id)
      end

      if pin_code.nil?
         pin_code = PinCode.create(:pin_code=>pcode,:city_id=>city.id)
      end
      return [country.id,state.id,city.id,pin_code.pin_code]
  end

  def save_university_address(params)
      univeristy_address = UniversityAddress.new
      univeristy_address.landline_number = params["landline"]
      univeristy_address.address1 = params["address_line1"]
      univeristy_address.address2 = params["address_line2"]
      univeristy_address.university_id = params["university_id"]
      country_id, state_id, city_id,pin_code = save_country_state_city_pin(params["country"],params["state"],params["city"],params["pin_code"])
      univeristy_address.country_id = country_id
      univeristy_address.state_id = state_id
      univeristy_address.city_id = city_id
      univeristy_address.pin_code = pin_code
      univeristy_address.save!
      return univeristy_address.id
  end

  def save_university_contact(params)
      university_contact = UniversityContactDetail.new
      university_contact.university_id = params["university_id"]
      university_contact.email_1 = params["email1"]
      university_contact.email_2 = params["email2"]
      university_contact.phone_number_1 = params["phone1"]
      university_contact.phone_number_2 = params["phone2"]
      university_contact.save!
  end

  def save_university_user(university_id)
        univ_user = UniversityUser.new
        univ_user.university_id = university_id
        univ_user.user_id = current_user.id
        univ_user.save!
  end
  
  def save_university(params)
      University.transaction do
        university = University.new
        university.name = params["university"]
        university.save!
        
        save_university_user(university.id)  

        univ_address_hash = {}
        univ_address_hash["landline"] = params["landline"]
        univ_address_hash["address_line1"] = params["address_line1"]
        univ_address_hash["address_line2"] = params["address_line2"]
        univ_address_hash["city"] = params["city"]
        univ_address_hash["state"] = params["state"]
        univ_address_hash["country"] = params["country"]
        univ_address_hash["pin_code"] = params["code"]
        univ_address_hash["university_id"] = university.id

        save_university_address(univ_address_hash)

        # save university contact details
        univ_contact_detail = {}
        univ_contact_detail["university_id"] = university.id
        univ_contact_detail["email1"] = params["email1"]
        univ_contact_detail["email2"] = params["email2"]
        univ_contact_detail["phone1"] = params["phone1"]
        univ_contact_detail["phone2"] = params["phone2"]
        save_university_contact(univ_contact_detail)
      end
  end


end