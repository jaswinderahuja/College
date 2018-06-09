class CampusInvite < ApplicationRecord

  belongs_to :campus
  belongs_to :department
  belongs_to :city
  has_many   :campus_addresses, through: :campus

  def create_campus_drive options
  		self.date_of_drive =  options["date_of_drive"]
      self.address = options["address_line_1"]
  		self.city_id = options["city"]
  		self.no_of_students =  options["no_of_students"]
  		self.department_id = options["dept"]
  		self.hod_email = options["hod_email"]
  		self.coordinator_email_1 = options["coordinator_email_1"]
  		self.coordinator_email_2 = options["coordinator_email_2"]
  		self.coordinator_phone_1 = options["phone_1"]
  		self.coordinator_phone_2 = options["phone_2"]
  		self.description = options["description"]
  		self.status = true
  		self.save!
  end


end
