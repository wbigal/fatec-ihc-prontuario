require 'rails_helper'

RSpec.describe Patients::MyMedicalRecordsController, type: :routing do
  describe '#index' do
    it do
      expect(get: '/pacientes/meu-prontuario').to route_to(
        'patients/my_medical_records#index',
        locale: 'pt-BR'
      )
    end
  end

  describe '#search_result' do
    it do
      expect(get: '/pacientes/meu-prontuario/resultado').to route_to(
        'patients/my_medical_records#search_result',
        locale: 'pt-BR'
      )
    end
  end

  describe '#show' do
    it do
      expect(get: '/pacientes/meu-prontuario/1910').to route_to(
        'patients/my_medical_records#show',
        locale: 'pt-BR',
        id: '1910'
      )
    end
  end
end
