require 'rails_helper'

RSpec.describe People::Login, type: :service do
  let(:correct_email) { Faker::Internet.email }
  let(:correct_password) { 'ABC123' }
  let(:email) { correct_email }
  let(:password) { correct_password }

  let!(:pessoa) do
    create(:pessoa, email: correct_email, senha: correct_password)
  end

  subject { People::Login.new(email: email, password: password) }

  before { create(:pessoa, :with_account) }

  context 'when email and password are corrects' do
    it { expect(subject.call).to eq(pessoa) }
  end

  context 'when password is incorrect' do
    let(:password) { 'incorrect' }
    it { expect(subject.call).to be_nil }
  end

  context 'when email is incorrect' do
    let(:email) { 'incorrect@incorrect.com' }
    it { expect(subject.call).to be_nil }
  end
end
