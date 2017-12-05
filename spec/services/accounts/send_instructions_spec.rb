require 'rails_helper'

RSpec.describe Accounts::SendInstructions, type: :service do
  let(:email) { 'test@fatec.ihc' }
  let(:remember_email) { email }
  let!(:pessoa) { create(:pessoa, :with_account, email: email) }
  let(:remember_link) { 'http://test' }

  subject do
    Accounts::SendInstructions.new(email: remember_email)
  end

  context 'when pessoa is present' do
    it do
      expect do
        subject.call
      end.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end

  context 'when pessoa is not present' do
    let(:remember_email) { 'invalid-email' }

    it do
      expect do
        subject.call
      end.to raise_error(Accounts::AccountNotFound)
    end
  end
end
