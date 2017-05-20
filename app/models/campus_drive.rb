class CampusDrive < ApplicationRecord
  belongs_to :college_detail
  belongs_to :department
end
