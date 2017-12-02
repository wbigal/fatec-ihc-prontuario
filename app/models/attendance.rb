class Attendance < ApplicationRecord
  belongs_to :person
  belongs_to :doctor
  has_one :permission
end
