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

  describe '#refused?' do
    context 'when actived permissao is not refused' do
      let(:permissao) { create(:permissao, nao_aceito: false) }
      it { expect(permissao.refused?).to be_falsy }
    end

    context 'when actived permissao is refused' do
      let(:permissao) { create(:permissao, nao_aceito: true) }
      it { expect(permissao.refused?).to be_truthy }
    end
  end

  describe '.actived' do
    let!(:permissao) { create(:permissao) }

    context 'when exists actived permissao' do
      it { expect(Permissao.actived).to eq([permissao]) }
    end

    context 'when actived permissao is revogada' do
      let!(:permissao) { create(:permissao, revogado: true) }
      it { expect(Permissao.actived).to be_blank }
    end

    context 'when actived permissao is nao_aceita' do
      let!(:permissao) { create(:permissao, nao_aceito: true) }
      it { expect(Permissao.actived).to be_blank }
    end

    context 'when actived permissao has atendimento' do
      let(:atendimento) { create(:atendimento) }
      let!(:permissao) { create(:permissao, atendimento: atendimento) }
      it { expect(Permissao.actived).to be_blank }
    end
  end

  describe '.granted' do
    context 'when actived permissao is not granted' do
      let!(:permissao) { create(:permissao, revogado: false) }
      it { expect(Permissao.granted).to eq([permissao]) }
    end

    context 'when actived permissao is not granted' do
      let!(:permissao) { create(:permissao, revogado: true) }
      it { expect(Permissao.granted).to be_blank }
    end
  end

  describe '.accepted' do
    context 'when actived permissao is accepted' do
      let!(:permissao) { create(:permissao, nao_aceito: false) }
      it { expect(Permissao.accepted).to eq([permissao]) }
    end

    context 'when actived permissao is not accepted' do
      let!(:permissao) { create(:permissao, nao_aceito: true) }
      it { expect(Permissao.accepted).to be_blank }
    end
  end

  describe '.pending_appointment' do
    context 'when actived permissao is pending_appointment' do
      let!(:permissao) { create(:permissao, atendimento: nil) }
      it { expect(Permissao.pending_appointment).to eq([permissao]) }
    end

    context 'when actived permissao is not pending_appointment' do
      let(:atendimento) { create(:atendimento) }
      let!(:permissao) { create(:permissao, atendimento: atendimento) }
      it { expect(Permissao.pending_appointment).to be_blank }
    end
  end

  describe '.current' do
    context 'when actived permissao is current' do
      let!(:permissao) { create(:permissao, data_limite: 1.day.from_now) }
      it { expect(Permissao.current).to eq([permissao]) }
    end

    context 'when actived permissao is not current' do
      let(:atendimento) { create(:atendimento) }
      let!(:permissao) { create(:permissao, data_limite: 1.day.ago) }
      it { expect(Permissao.current).to be_blank }
    end
  end
end
