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

  describe 'GET patient_records' do
    let(:permissao_id) { 0 }

    before do
      create(:atendimento)
      create(:permissao)
      process :patient_records, method: :get, params: {
        locale: 'pt-BR',
        permissao_id: permissao_id
      }
    end

    context 'when exists permissoes' do
      let(:permissao) { create(:permissao, medico: current_pessoa_medico) }
      let!(:atendimento) { create(:atendimento, pessoa: permissao.pessoa) }
      let(:permissao_id) { permissao.id }
      it { expect(response).to render_template(:patient_records) }
      it { expect(response.status).to eq(200) }
      it { expect(assigns(:permissao)).to eq(permissao) }
      it { expect(assigns(:atendimentos)).to eq([atendimento]) }
    end

    context 'when not exists permissoes' do
      it { expect(response).to redirect_to(action: :index) }
    end
  end

  describe 'GET new' do
    let(:permissao_id) { 0 }

    before do
      process :new, method: :get, params: {
        locale: 'pt-BR',
        permissao_id: permissao_id
      }
    end

    context 'when exists permissoes' do
      let!(:permissao) { create(:permissao, medico: current_pessoa_medico) }
      let(:permissao_id) { permissao.id }
      it { expect(response).to render_template(:new) }
      it { expect(response.status).to eq(200) }
      it { expect(assigns(:permissao)).to eq(permissao) }
      it { expect(assigns(:atendimento)).to be_an_instance_of(Atendimento) }
    end

    context 'when not exists permissoes' do
      it { expect(response).to redirect_to(action: :index) }
    end
  end

  describe 'POST create' do
    let(:permissao) { create(:permissao, medico: current_pessoa_medico) }
    let(:medico) { permissao.medico }
    let(:atendimento_params) do
      Hash[
        sintomas: 'sintomas',
        diagnosticos: 'diagnosticos',
        prescricao_medicamentos: 'prescricao_medicamentos',
        prescricao_procedimentos: 'prescricao_procedimentos'
      ]
    end

    before do
      process :create, method: :post, params: {
        locale: 'pt-BR',
        atendimento: atendimento_params,
        permissao_id: permissao.id
      }
    end

    context 'when atendimento_params are valid' do
      it do
        expect(response).to redirect_to(
          controller: 'doctors/my_appointments',
          action: :show,
          id: Atendimento.last.id,
          back_to: '/medicos/meus-atendimentos'
        )
      end
      it { expect(flash[:error]).to be_blank }
    end

    context 'when permission is not valid' do
      let(:permissao) { create(:permissao) }
      it { expect(response).to redirect_to(action: :index) }
      it do
        expect(flash[:error]).to eq(
          'Você não possui permissão para acessar o prontuário.'
        )
      end
    end

    context 'when atendimento_params are not valid' do
      let(:atendimento_params) do
        Hash[
          sintomas: '',
          diagnosticos: '',
          prescricao_medicamentos: '',
          prescricao_procedimentos: ''
        ]
      end

      it { expect(response).to render_template(:new) }
      it { expect(response.status).to eq(200) }
      it { expect(assigns(:permissao)).to eq(permissao) }
      it { expect(assigns(:atendimento)).to be_an_instance_of(Atendimento) }
    end
  end
end
