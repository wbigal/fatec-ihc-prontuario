require 'rails_helper'

RSpec.describe Accounts::RegistrationsController, type: :routing do
  describe '#index' do
    it do
      expect(get: '/contas/inscricoes').to route_to(
        'accounts/registrations#index',
        locale: 'pt-BR'
      )
    end
  end

  describe '#new' do
    it do
      expect(get: '/contas/inscricoes/novo').to route_to(
        'accounts/registrations#new',
        locale: 'pt-BR'
      )
    end
  end

  describe '#create' do
    it do
      expect(post: '/contas/inscricoes').to route_to(
        'accounts/registrations#create',
        locale: 'pt-BR'
      )
    end
  end
end
