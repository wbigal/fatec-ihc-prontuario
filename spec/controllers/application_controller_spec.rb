require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe '#current_pessoa' do
    context 'when current_pessoa is present' do
      let!(:pessoa) { create(:pessoa, :with_account) }

      before { controller.current_pessoa = pessoa }

      it { expect(controller.current_pessoa).to eq(pessoa) }
      it { expect(controller.pessoa_signed_in?).to be_truthy }
    end

    context 'when current_pessoa is not present' do
      it { expect(controller.current_pessoa).to be_nil }
      it { expect(controller.pessoa_signed_in?).to be_falsy }
    end
  end
end
