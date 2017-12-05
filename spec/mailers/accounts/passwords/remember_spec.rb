require 'rails_helper'

RSpec.describe Accounts::Passwords::RememberMailer, type: :mailer do
  let(:pessoa) { create(:pessoa, :with_account) }
  let(:remember_link) { 'http://test' }

  subject do
    Accounts::Passwords::RememberMailer.instructions(
      pessoa: pessoa,
      remember_link: remember_link
    ).deliver_now
  end

  it do
    expect(subject.subject).to eq('[SPE] Instruções para criar uma nova senha')
  end

  it { expect(subject.to).to eq([pessoa.email]) }
  it { expect(subject.body.encoded).to match(pessoa.nome_completo) }
  it { expect(subject.body.encoded).to match(remember_link) }
end
