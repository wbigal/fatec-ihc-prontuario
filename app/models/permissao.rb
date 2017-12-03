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

class Permissao < ApplicationRecord
  belongs_to :pessoa, required: true
  belongs_to :medico, required: true
  belongs_to :atendimento, required: false

  validates :data_limite, presence: true
  validates :data_autorizacao, presence: true
  validates :nao_aceito, inclusion: { in: [true, false] }
  validates :revogado, inclusion: { in: [true, false] }

  scope :actived, (lambda do |pessoa, medico|
    where(medico: medico, pessoa: pessoa, nao_aceito: false, revogado: false).
    where('data_limite > ?', Time.zone.now)
  end)
end
