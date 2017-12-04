require 'rails_helper'

RSpec.describe Doctors::PermissionsController, type: :routing do
  describe '#delete' do
    it do
      expect(delete: '/medicos/autorizacoes/1910').to route_to(
        'doctors/permissions#destroy',
        id: '1910',
        locale: 'pt-BR'
      )
    end
  end
end
