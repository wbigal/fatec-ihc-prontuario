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

  has_many :atendimentos, dependent: :destroy
  has_many :permissoes, dependent: :destroy, class_name: 'Permissao'

  validates :crm, presence: true,
                  numericality: { only_integer: true, greater_than: 0 },
                  uniqueness: true

  validates :pessoa, presence: true, uniqueness: true
end
