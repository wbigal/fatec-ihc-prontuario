require 'rails_helper'

RSpec.describe Accounts::PasswordsController, type: :routing do
  describe '#index' do
    it do
      expect(get: '/contas/senhas').to route_to(
        'accounts/passwords#index',
        locale: 'pt-BR'
      )
    end
  end

  describe '#remember' do
    it do
      expect(get: '/contas/senhas/lembrar').to route_to(
        'accounts/passwords#remember',
        locale: 'pt-BR'
      )
    end
  end

  describe '#edit' do
    it do
      expect(get: '/contas/senhas/XPTO/editar').to route_to(
        'accounts/passwords#edit',
        locale: 'pt-BR',
        id: 'XPTO'
      )
    end
  end

  describe '#update' do
    it do
      expect(patch: '/contas/senhas/XPTO').to route_to(
        'accounts/passwords#update',
        locale: 'pt-BR',
        id: 'XPTO'
      )
    end
  end
end
