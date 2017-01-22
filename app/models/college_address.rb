class CollegeAddress < ApplicationRecord
  belongs_to :pin_code
  belongs_to :college

end
