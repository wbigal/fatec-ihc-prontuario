class Person < ApplicationRecord
	has_many :permissions
	has_many :attendances
end
