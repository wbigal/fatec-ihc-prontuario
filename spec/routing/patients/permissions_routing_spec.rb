require 'rails_helper'

RSpec.describe Patients::PermissionsController, type: :routing do
  describe '#index' do
    it do
      expect(get: '/pacientes/autorizacoes').to route_to(
        'patients/permissions#index',
        locale: 'pt-BR'
      )
    end
  end

  describe '#search_doctor' do
    it do
      expect(get: '/pacientes/autorizacoes/pesquisar-medico').to route_to(
        'patients/permissions#search_doctor',
        locale: 'pt-BR'
      )
    end
  end

  describe '#new' do
    it do
      expect(get: '/pacientes/autorizacoes/novo').to route_to(
        'patients/permissions#new',
        locale: 'pt-BR'
      )
    end
  end

  describe '#create' do
    it do
      expect(post: '/pacientes/autorizacoes').to route_to(
        'patients/permissions#create',
        locale: 'pt-BR'
      )
    end
  end

  describe '#delete' do
    it do
      expect(delete: '/pacientes/autorizacoes/1910').to route_to(
        'patients/permissions#destroy',
        id: '1910',
        locale: 'pt-BR'
      )
    end
  end
end
