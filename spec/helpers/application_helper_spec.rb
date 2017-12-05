require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#pessoa_signed_in?' do
    it { expect(helper).to delegate_method(:pessoa_signed_in?).to(:controller) }
  end

  describe '#current_pessoa' do
    it { expect(helper).to delegate_method(:current_pessoa).to(:controller) }
  end

  describe '#medico_signed_in?' do
    it { expect(helper).to respond_to(:medico_signed_in?) }

    context 'when pessoa is medico' do
      let(:medico) { create(:medico) }

      before do
        allow(helper).to receive(:pessoa_signed_in?).and_return(true)
        allow(helper).to receive(:current_pessoa).and_return(medico.pessoa)
      end

      it { expect(helper.medico_signed_in?).to be_truthy }
    end

    context 'when pessoa is not signed in' do
      let(:medico) { create(:medico) }

      before do
        allow(helper).to receive(:pessoa_signed_in?).and_return(false)
        allow(helper).to receive(:current_pessoa).and_return(medico.pessoa)
      end

      it { expect(helper.medico_signed_in?).to be_falsy }
    end

    context 'when pessoa is not a medico' do
      let(:pessoa) { create(:pessoa) }

      before do
        allow(helper).to receive(:pessoa_signed_in?).and_return(false)
        allow(helper).to receive(:current_pessoa).and_return(pessoa)
      end

      it { expect(helper.medico_signed_in?).to be_falsy }
    end
  end
end
