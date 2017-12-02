class Permission < ApplicationRecord
  belongs_to :attendance
  belongs_to :doctor
  belongs_to :person
end
