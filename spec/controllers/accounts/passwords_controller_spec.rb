require 'rails_helper'

RSpec.describe Accounts::PasswordsController, type: :controller do
  describe 'GET index' do
    before do
      process :index, method: :get, params: { locale: 'pt-BR' }
    end

    it { expect(response).to render_template('index') }
    it do
      expect(assigns(:remember)).to be_instance_of(
        Accounts::Passwords::RememberForm
      )
    end
  end

  describe 'GET remember' do
    let(:pessoa) { create(:pessoa, :with_account) }
    let(:password_params) { Hash[email: pessoa.email] }

    before do
      process :remember, method: :get, params: {
        locale: 'pt-BR',
        accounts_passwords_remember_form: password_params
      }
    end

    it do
      expect(assigns(:remember)).to be_instance_of(
        Accounts::Passwords::RememberForm
      )
    end

    context 'when remember form and account are valid' do
      it { expect(response).to redirect_to('/contas/sessoes/novo') }
    end

    context 'when remember form is not valid' do
      let(:password_params) { Hash[email: nil] }
      it { expect(response).to render_template('index') }
    end

    context 'when account is not valid' do
      let(:password_params) { Hash[email: 'invalid-email@invlid.co'] }
      it { expect(response).to redirect_to('/contas/senhas') }
    end
  end

  describe 'GET edit' do
    let(:pessoa) { create(:pessoa, :with_account) }
    let(:id) { SecureMessage.encrypt(pessoa.id) }

    before do
      process :edit, method: :get, params: { locale: 'pt-BR', id: id }
    end

    it { expect(response).to render_template('edit') }
    it do
      expect(assigns(:create_password)).to be_instance_of(
        Accounts::Passwords::CreateForm
      )
    end
  end

  describe 'PATCH update' do
    let(:pessoa) { create(:pessoa, :with_account, senha: 'oldpwd') }
    let(:id) { SecureMessage.encrypt(pessoa.id) }
    let(:new_password) { 'newpwd' }
    let(:create_password_params) do
      Hash[password: new_password, password_confirmation: new_password]
    end

    before do
      process :update, method: :patch, params: {
        locale: 'pt-BR',
        id: id,
        accounts_passwords_create_form: create_password_params
      }
    end

    it do
      expect(assigns(:create_password)).to be_instance_of(
        Accounts::Passwords::CreateForm
      )
    end

    context 'when form data and account are valid' do
      it do
        pessoa.reload
        expect(pessoa.correct_senha?(new_password)).to be_truthy
      end

      it { expect(response).to redirect_to('/contas/sessoes/novo') }
    end

    context 'when form data is not valid' do
      let(:create_password_params) do
        Hash[password: nil, password_confirmation: new_password]
      end
      it { expect(response).to render_template('edit') }
    end

    context 'when account is not valid' do
      let(:id) { 'invalid' }
      it { expect(response).to redirect_to('/contas/senhas') }
    end
  end
end
