require 'rails_helper'

RSpec.describe Doctors::MedicalRecordsController, type: :routing do
  describe '#index' do
    it do
      expect(get: '/medicos/registros').to route_to(
        'doctors/medical_records#index',
        locale: 'pt-BR'
      )
    end
  end
end
