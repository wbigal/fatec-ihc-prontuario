class Doctor < ApplicationRecord
  belongs_to :person
  has_many :attendances
  has_many :permissions

  validates_presence_of :crm
end
