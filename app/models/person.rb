class Person < ApplicationRecord
	has_many :permissions
	has_many :attendances

	validates_presence_of :cns, :email, :password, :birth_date
end
