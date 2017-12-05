require 'rails_helper'

RSpec.describe Accounts::Create, type: :service do
  let(:pessoa) { create(:pessoa) }
  let(:cns) { pessoa.cns }
  let(:email) { Faker::Internet.email }
  let(:password) { 'ABC123' }

  subject do
    Accounts::Create.new(cns: cns, email: email, password: password)
  end

  it { expect(subject.call).to be_truthy }

  it do
    subject.call
    pessoa.reload
    expect(pessoa.account?).to be_truthy
  end
end
