class Permission < ApplicationRecord
  belongs_to :attendance
  belongs_to :doctor
  belongs_to :person

  validates_presence_of :date
end
