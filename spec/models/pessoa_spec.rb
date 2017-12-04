# == Schema Information
#
# Table name: pessoas
#
#  id              :integer          not null, primary key
#  cns             :string(16)       not null
#  nome_completo   :string(255)      not null
#  data_nascimento :date             not null
#  email           :string(100)
#  senha           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe Pessoa, type: :model do
  it 'has a valid factory' do
    expect(create(:pessoa)).to be_valid
  end

  describe '#medico' do
    it { is_expected.to have_one(:medico) }
  end

  describe '#atendimentos' do
    it { is_expected.to have_many(:atendimentos) }
  end

  describe '#permissoes' do
    it { is_expected.to have_many(:permissoes) }
  end

  describe '#cns' do
    it { is_expected.to validate_presence_of(:cns) }
    it { is_expected.to validate_length_of(:cns).is_equal_to(16) }

    it do
      create(:pessoa)
      is_expected.to validate_uniqueness_of(:cns).case_insensitive
    end
  end

  describe '#nome_completo' do
    it { is_expected.to validate_presence_of(:nome_completo) }
    it { is_expected.to validate_length_of(:nome_completo).is_at_most(255) }
  end

  describe '#data_nascimento' do
    it { is_expected.to validate_presence_of(:data_nascimento) }
  end

  describe '#senha' do
    it do
      is_expected.to validate_length_of(:senha).is_at_least(6).is_at_most(10)
    end

    context 'when senha will be encrypted' do
      let(:email) { Faker::Internet.email }
      let(:password) { 'ACB1234' }
      let!(:pessoa) { create(:pessoa, email: email, senha: password) }

      it { expect(Pessoa.find(pessoa.id).senha.to_s).not_to eq(password) }
    end
  end

  describe '#email' do
    it { is_expected.to validate_length_of(:email).is_at_most(100) }

    it do
      create(:pessoa)
      is_expected.to validate_uniqueness_of(:email).case_insensitive
    end
  end

  describe '#correct_senha?' do
    let(:email) { Faker::Internet.email }
    let(:password) { 'ACB1234' }
    let!(:pessoa) { create(:pessoa, email: email, senha: password) }

    context 'when senha is present' do
      it do
        expect(Pessoa.find(pessoa.id).correct_senha?(password)).to be_truthy
      end
    end

    context 'when senha is not present' do
      let(:email) { nil }
      let(:password) { nil }
      it do
        expect(Pessoa.find(pessoa.id).correct_senha?(password)).to be_falsy
      end
    end
  end

  describe 'setup account' do
    let(:email) { Faker::Internet.email }
    let(:password) { 'ACB1234' }

    context 'when the email and senha are present' do
      it { expect(create(:pessoa, email: email, senha: password)).to be_valid }
    end

    context 'when the email is blank' do
      it do
        expect(build(:pessoa, email: nil, senha: password)).not_to be_valid
      end
    end

    context 'when the email is blank' do
      it do
        expect(build(:pessoa, email: email, senha: nil)).not_to be_valid
      end
    end
  end
end
