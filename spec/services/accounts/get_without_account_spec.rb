require 'rails_helper'

RSpec.describe Accounts::GetWithoutAccount, type: :service do
  let(:pessoa) { create(:pessoa) }
  let(:cns) { pessoa.cns }

  subject { Accounts::GetWithoutAccount.new(cns: cns) }

  context 'when pessoa has not account' do
    it { expect(subject.call).to eq(pessoa) }
  end

  context 'when pessoa has account' do
    let(:pessoa) { create(:pessoa, :with_account) }
    it { expect { subject.call }.to raise_error(Accounts::AlreadyExistsError) }
  end

  context 'when pessoa not exists' do
    let(:cns) { 0 }
    it { expect { subject.call }.to raise_error(Accounts::PessoaNotFound) }
  end
end
