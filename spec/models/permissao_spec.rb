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

require 'rails_helper'

RSpec.describe Permissao, type: :model do
  it 'has a valid factory' do
    expect(create(:permissao)).to be_valid
  end

  describe '#pessoa' do
    it { is_expected.to belong_to(:pessoa) }
    it { is_expected.to validate_presence_of(:pessoa).with_message(:required) }
  end

  describe '#medico' do
    it { is_expected.to belong_to(:medico) }
    it { is_expected.to validate_presence_of(:medico).with_message(:required) }
  end

  describe '#atendimento' do
    it { is_expected.to belong_to(:atendimento) }
  end

  describe '#data_limite' do
    it { is_expected.to validate_presence_of(:data_limite) }
  end

  describe '#data_autorizacao' do
    it { is_expected.to validate_presence_of(:data_autorizacao) }
  end

  describe '#nao_aceito' do
    it { is_expected.to respond_to(:nao_aceito) }
  end

  describe '#revogado' do
    it { is_expected.to respond_to(:revogado) }
  end
end
