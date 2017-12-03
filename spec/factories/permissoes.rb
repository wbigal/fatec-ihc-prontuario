# == Schema Information
#
# Table name: permissoes
#
#  id               :integer          not null, primary key
#  pessoa_id        :integer          not null
#  medico_id        :integer          not null
#  atendimento_id   :integer
#  data_limite      :datetime         not null
#  data_autorizacao :datetime         not null
#  nao_aceito       :boolean          default(FALSE), not null
#  revogado         :boolean          default(FALSE), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryBot.define do
  factory :permissao, class: 'Permissao' do
    pessoa
    medico
    data_limite 1.hour.from_now
    data_autorizacao Time.zone.now
    nao_aceito false
    revogado false
  end
end
