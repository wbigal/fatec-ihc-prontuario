require 'rails_helper'

RSpec.describe Accounts::SessionsController, type: :routing do
  describe '#new' do
    it do
      expect(get: '/contas/sessoes/novo').to route_to(
        'accounts/sessions#new',
        locale: 'pt-BR'
      )
    end
  end

  describe '#create' do
    it do
      expect(post: '/contas/sessoes').to route_to(
        'accounts/sessions#create',
        locale: 'pt-BR'
      )
    end
  end

  describe '#delete' do
    it do
      expect(delete: '/contas/sessoes').to route_to(
        'accounts/sessions#destroy',
        locale: 'pt-BR'
      )
    end
  end
end
