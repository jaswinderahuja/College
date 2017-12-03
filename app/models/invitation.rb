class Invitation < ApplicationRecord
  belongs_to :campus
  belongs_to :user
end
