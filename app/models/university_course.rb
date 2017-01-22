class UniversityCourse < ApplicationRecord
  belongs_to :university
  belongs_to :course
end
