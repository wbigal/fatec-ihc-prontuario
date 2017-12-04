require 'rails_helper'

RSpec.describe Doctors::MedicalRecordsController, :authenticated_doctor,
               type: :controller do
  it { is_expected.to be_kind_of(Doctors::BaseController) }

  before do
    create(:permissao)
  end

  describe 'GET index' do
    before do
      process :index, method: :get, params: { locale: 'pt-BR' }
    end

    context 'when exists permissoes' do
      let!(:permissao) { create(:permissao, medico: current_pessoa_medico) }
      it { expect(response).to render_template(:index) }
      it { expect(response.status).to eq(200) }
      it { expect(assigns(:permissoes)).to eq([permissao]) }
    end

    context 'when not exists permissoes' do
      it { expect(response).to render_template(:index) }
      it { expect(response.status).to eq(200) }
      it { expect(assigns(:permissoes)).to eq([]) }
    end
  end
end
