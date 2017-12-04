require 'rails_helper'

RSpec.describe Doctors::MyAppointmentsController, type: :routing do
  describe '#index' do
    it do
      expect(get: '/medicos/meus-atendimentos').to route_to(
        'doctors/my_appointments#index',
        locale: 'pt-BR'
      )
    end
  end

  describe '#search_result' do
    it do
      expect(get: '/medicos/meus-atendimentos/resultado').to route_to(
        'doctors/my_appointments#search_result',
        locale: 'pt-BR'
      )
    end
  end

  describe '#show' do
    it do
      expect(get: '/medicos/meus-atendimentos/1910').to route_to(
        'doctors/my_appointments#show',
        locale: 'pt-BR',
        id: '1910'
      )
    end
  end
end
