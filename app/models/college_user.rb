class CollegeUser < ApplicationRecord
  belongs_to :college
  belongs_to :user
end
