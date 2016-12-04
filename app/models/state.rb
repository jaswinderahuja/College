class State < ApplicationRecord
  belongs_to :countries
  has_many :cities
end
