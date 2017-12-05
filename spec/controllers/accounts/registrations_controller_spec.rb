require 'rails_helper'

RSpec.describe Accounts::RegistrationsController, type: :controller do
  describe 'GET index' do
    before do
      process :index, method: :get, params: { locale: 'pt-BR' }
    end

    it { expect(response).to render_template('index') }
    it do
      expect(assigns(:registration)).to be_instance_of(
        Accounts::Registrations::SearchCnsForm
      )
    end
  end

  describe 'GET new' do
    let(:pessoa) { create(:pessoa) }
    let(:cns) { pessoa.cns }
    let(:account_params) { Hash[cns: cns] }

    before do
      process :new, method: :get, params: {
        locale: 'pt-BR',
        accounts_registrations_search_cns_form: account_params
      }
    end

    context 'when pessoa has not account' do
      it { expect(response).to render_template('new') }

      it do
        expect(assigns(:registration)).to be_instance_of(
          Accounts::Registrations::SearchCnsForm
        )
      end

      it do
        expect(assigns(:account)).to be_instance_of(
          Accounts::Registrations::AccountForm
        )
      end
    end

    context 'when pessoa has account' do
      let(:pessoa) { create(:pessoa, :with_account) }

      it { expect(response).to redirect_to(action: :index) }

      it do
        expect(assigns(:registration)).to be_instance_of(
          Accounts::Registrations::SearchCnsForm
        )
      end

      it { expect(assigns(:account)).to be_blank }
    end

    context 'when params are incorrect' do
      let(:cns) { nil }
      it { expect(response).to render_template('index') }
    end
  end

  describe 'GET post' do
    let(:email) { Faker::Internet.email }
    let(:password) { 'ABC123' }
    let(:password_confirmation) { 'ABC123' }
    let(:pessoa) { create(:pessoa) }
    let(:cns) { pessoa.cns }

    let(:account_params) do
      Hash[
        cns: cns,
        email: email,
        password: password,
        password_confirmation: password_confirmation
      ]
    end

    before do
      process :create, method: :post, params: {
        accounts_registrations_account_form: account_params,
        locale: 'pt-BR'
      }
    end

    context 'when account informations are correct' do
      it do
        pessoa.reload
        expect(pessoa.account?).to be_truthy
      end

      it { expect(response).to redirect_to('/contas/sessoes/novo') }
    end

    context 'when account informations are not correct' do
      let(:password) { 'incorrect' }

      it do
        pessoa.reload
        expect(pessoa.account?).to be_falsy
      end

      it { expect(response).to render_template('new') }

      it do
        expect(assigns(:account)).to be_instance_of(
          Accounts::Registrations::AccountForm
        )
      end
    end
  end
end
