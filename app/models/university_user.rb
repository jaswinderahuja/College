class UniversityUser < ApplicationRecord
  belongs_to :university
  belongs_to :user
end
