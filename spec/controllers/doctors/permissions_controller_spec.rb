require 'rails_helper'

RSpec.describe Doctors::PermissionsController, :authenticated_doctor,
               type: :controller do
  it { is_expected.to be_kind_of(Doctors::BaseController) }

  describe 'DELETE destroy' do
    let!(:permissao) { create(:permissao, medico: current_pessoa_medico) }

    before do
      process :destroy, method: :delete, params: {
        locale: 'pt-BR',
        id: permissao.id
      }
    end

    it do
      permissao.reload
      expect(permissao.nao_aceito).to be_truthy
    end
  end
end
