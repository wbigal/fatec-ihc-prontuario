require 'rails_helper'

RSpec.describe Patients::PermissionsController, :authenticated,
               type: :controller do
  it { is_expected.to be_kind_of(AuthenticatedController) }

  before do
    create(:permissao)
  end

  describe 'GET index' do
    before do
      process :index, method: :get, params: { locale: 'pt-BR' }
    end

    context 'when exists permissoes' do
      let!(:permissao) { create(:permissao, pessoa: current_pessoa) }
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

  describe 'GET search_doctor' do
    before do
      process :search_doctor, method: :get, params: { locale: 'pt-BR' }
    end

    it { expect(response).to render_template(:search_doctor) }
    it { expect(response.status).to eq(200) }
  end

  describe 'GET new' do
    let(:medico) { create(:medico) }
    let(:crm) { medico.crm }

    before do
      process :new, method: :get, params: { locale: 'pt-BR', crm: crm }
    end

    context 'when the crm is valid' do
      it { expect(response).to render_template(:new) }
      it { expect(response.status).to eq(200) }
      it { expect(assigns(:medico)).to eq(medico) }
      it { expect(assigns(:permissao)).to be_an_instance_of(Permissao) }
    end

    context 'when the crm is not valid' do
      let(:crm) { 0 }
      it { expect(response).to redirect_to(action: :search_doctor) }
    end
  end

  describe 'POST create' do
    let(:medico) { create(:medico) }
    let(:pessoa) { current_pessoa }
    let(:data_limite) { 2.hours.from_now }
    let(:permissao_params) do
      Hash[medico_id: medico.id, data_limite: data_limite]
    end

    before do
      process :create, method: :post, params: {
        locale: 'pt-BR',
        permissao: permissao_params
      }
    end

    context 'when permissao_params are valid' do
      it { expect(response).to redirect_to(action: :index) }
    end

    context 'when permissao_params are not valid' do
      let(:data_limite) { nil }
      it { expect(response).to render_template(:new) }
      it { expect(response.status).to eq(200) }
      it { expect(assigns(:medico)).to eq(medico) }
      it { expect(assigns(:permissao).errors).not_to be_blank }
      it { expect(assigns(:permissao)).to be_an_instance_of(Permissao) }
    end
  end

  describe 'DELETE destroy' do
    let!(:permissao) { create(:permissao, pessoa: current_pessoa) }

    before do
      process :destroy, method: :delete, params: {
        locale: 'pt-BR',
        id: permissao.id
      }
    end

    it { expect(response).to redirect_to(action: :index) }

    it do
      permissao.reload
      expect(permissao.revogado).to be_truthy
    end
  end
end
