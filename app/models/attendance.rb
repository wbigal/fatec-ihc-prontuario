class Attendance < ApplicationRecord
  belongs_to :person
  belongs_to :doctor
end
