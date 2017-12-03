# == Schema Information
#
# Table name: medicos
#
#  id         :integer          not null, primary key
#  pessoa_id  :integer          not null
#  crm        :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Medico < ApplicationRecord
  belongs_to :pessoa, required: true

  validates :crm, presence: true,
                  numericality: { only_integer: true, greater_than: 0 }
end
