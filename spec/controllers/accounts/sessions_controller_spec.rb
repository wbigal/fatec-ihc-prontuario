require 'rails_helper'

RSpec.describe Accounts::SessionsController, type: :controller do
  describe 'GET new' do
    before do
      process :new, method: :get, params: { locale: 'pt-BR' }
    end

    it { expect(response).to render_template('new') }
    it { expect(assigns(:pessoa)).to be_a_new(Pessoa) }
  end

  describe 'GET post' do
    let(:correct_email) { Faker::Internet.email }
    let(:correct_password) { 'ABC123' }
    let(:email) { correct_email }
    let(:password) { correct_password }
    let(:pessoa_params) { Hash[email: email, senha: password] }
    let!(:pessoa) do
      create(:pessoa, email: correct_email, senha: correct_password)
    end

    before do
      process :create, method: :post, params: {
        pessoa: pessoa_params,
        locale: 'pt-BR'
      }
    end

    context 'when account informations are correct' do
      it { expect(controller.current_pessoa).to eq(pessoa) }
      it { expect(response).to redirect_to('/') }
    end

    context 'when account informations are not correct' do
      let(:password) { 'incorrect' }
      it { expect(controller.current_pessoa).to be_nil }
      it { expect(response).to redirect_to('/contas/sessoes/novo') }
      it { expect(flash[:error]).to eq('E-mail ou senha inválidos') }
    end
  end
end
