class Doctor < ApplicationRecord
  belongs_to :person
  has_many :attendances
  has_many :permissions
end
