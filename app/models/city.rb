class City < ApplicationRecord
  belongs_to :state
  has_many :pin_codes
end
