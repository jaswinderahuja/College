class CollegeContactDetail < ApplicationRecord
  belongs_to :college_detail

  def self.create_new_college_contact options
      college_contact = CollegeContactDetail.new
      college_contact.create_college_contact options
      return college_contact
  end

  def create_college_contact(params)
      self.college_detail_id = params["college_detail_id"]
      self.email_1 = params["email_1"]
      self.email_2 = params["email_2"]
      self.phone_number_1 = params["phone_1"]
      self.phone_number_2 = params["phone_2"]
      self.landline_number = params["landline_no"]
      self.save!
  end
end
