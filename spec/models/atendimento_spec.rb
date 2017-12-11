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

require 'rails_helper'

RSpec.describe Atendimento, type: :model do
  it { is_expected.to be_kind_of(Elasticsearch::Model) }
  it { is_expected.to be_kind_of(Elasticsearch::Model::Callbacks) }

  it 'has a valid factory' do
    expect(create(:atendimento)).to be_valid
  end

  describe '#pessoa' do
    it { is_expected.to belong_to(:pessoa) }
    it { is_expected.to validate_presence_of(:pessoa).with_message(:required) }
  end

  describe '#medico' do
    it { is_expected.to belong_to(:medico) }
    it { is_expected.to validate_presence_of(:medico).with_message(:required) }
  end

  describe '#permissao' do
    it { is_expected.to have_one(:permissao) }
  end

  describe '#data_atendimento' do
    it { is_expected.to validate_presence_of(:data_atendimento) }
  end

  describe '#sintomas' do
    it { is_expected.to validate_presence_of(:sintomas) }
  end

  describe '#diagnosticos' do
    it { is_expected.to validate_presence_of(:diagnosticos) }
  end

  describe '#prescricao_medicamentos' do
    it { is_expected.to validate_presence_of(:prescricao_medicamentos) }
  end

  describe '#prescricao_procedimentos' do
    it { is_expected.to validate_presence_of(:prescricao_procedimentos) }
  end
end
