# == Schema Information
#
# Table name: atendimentos
#
#  id                       :integer          not null, primary key
#  pessoa_id                :integer          not null
#  medico_id                :integer          not null
#  data_atendimento         :datetime         not null
#  sintomas                 :text             not null
#  diagnosticos             :text             not null
#  prescricao_medicamentos  :text             not null
#  prescricao_procedimentos :text             not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

class Atendimento < ApplicationRecord
  belongs_to :pessoa, required: true
  belongs_to :medico, required: true

  validates :data_atendimento, presence: true
  validates :sintomas, presence: true
  validates :diagnosticos, presence: true
  validates :prescricao_medicamentos, presence: true
  validates :prescricao_procedimentos, presence: true
end
