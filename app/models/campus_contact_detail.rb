class CampusContactDetail < ApplicationRecord
  self.primary_key = "campus_id"
  belongs_to :campus


  def self.create_new_campus_contact options
      campus_contact = CampusContactDetail.new
      campus_contact.create_campus_contact options
      return campus_contact
  end

  def create_campus_contact(params)
      self.campus_id = params["campus_id"]
      self.email_1 = params["email_id_1"]
      self.email_2 = params["email_id_2"]
      self.phone_number_1 = params["phone_1"]
      self.phone_number_2 = params["phone_2"]
      self.landline_number = params["landline_no"]
      self.save!
  end
end
