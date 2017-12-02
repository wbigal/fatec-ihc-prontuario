class Attendance < ApplicationRecord
  belongs_to :person
  belongs_to :doctor
  has_one :permission

  validates_presence_of :date, :symptoms, :diagnostic
end
