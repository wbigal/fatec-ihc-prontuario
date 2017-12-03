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

FactoryBot.define do
  factory :atendimento do
    pessoa
    medico
    data_atendimento Time.zone.now
    sintomas { Faker::Lorem.paragraph(2) }
    diagnosticos { Faker::Lorem.paragraph(2) }
    prescricao_medicamentos { Faker::Lorem.paragraph(2) }
    prescricao_procedimentos { Faker::Lorem.paragraph(2) }
  end
end
