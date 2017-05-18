class UniversityContactDetail < ApplicationRecord
  belongs_to :university

  def self.create_new_university_contact options
      university_contact = UniversityContactDetail.new
      university_contact.create_university_contact options
      return university_contact
  end

  def create_university_contact(params)
      self.university_id = params["university_id"]
      self.email_1 = params["email_1"]
      self.email_2 = params["email_2"]
      self.phone_number_1 = params["phone_1"]
      self.phone_number_2 = params["phone_2"]
      self.landline_number = params["landline_no"]
      self.save!
  end

end
