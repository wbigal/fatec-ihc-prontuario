require 'rails_helper'

RSpec.describe Accounts::Registrations::AccountForm, type: :form do
  it { is_expected.to be_kind_of(FormBase) }

  describe '#cns' do
    it { is_expected.to validate_presence_of(:cns) }
    it { is_expected.to validate_length_of(:cns).is_equal_to(16) }
  end

  describe '#email' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_length_of(:email).is_at_most(100) }
  end

  describe '#password' do
    it { is_expected.to validate_presence_of(:password) }
    it do
      is_expected.to validate_length_of(:password).is_at_least(6).is_at_most(10)
    end
  end

  describe '#password_confirmation' do
    let(:password) { 'ACB123' }
    let(:password_confirmation) { 'ACB123' }

    subject do
      Accounts::Registrations::AccountForm.new(
        password: password,
        password_confirmation: password_confirmation
      )
    end

    it { is_expected.to validate_presence_of(:password_confirmation) }
    it do
      is_expected.to validate_length_of(:password_confirmation).
        is_at_least(6).
        is_at_most(10)
    end

    context 'when password and confirmation have the same value' do
      before { subject.valid? }
      it { expect(subject.errors).not_to have_key(:password_confirmation) }
    end

    context 'when password and confirmation have differents values' do
      let(:password_confirmation) { '123ACB' }
      before { subject.valid? }
      it { expect(subject.errors).to have_key(:password_confirmation) }
    end
  end
end
