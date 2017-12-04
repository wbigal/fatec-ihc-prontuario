require 'rails_helper'

RSpec.describe Patients::MyMedicalRecordsController, :authenticated,
               type: :controller do
  it { is_expected.to be_kind_of(AuthenticatedController) }

  describe 'GET index' do
    before do
      process :index, method: :get, params: { locale: 'pt-BR' }
    end

    it { expect(response).to render_template(:index) }
    it { expect(response.status).to eq(200) }
    it do
      expect(assigns(:search)).to be_an_instance_of(
        Patients::MyMedicalRecords::SearchForm
      )
    end
  end

  describe 'GET search_result' do
    let(:atendimento) { create(:atendimento, pessoa: current_pessoa) }
    let(:search_params) do
      Hash[
        initial_date: 1.day.ago,
        final_date: 1.day.from_now,
        doctor_name: atendimento.medico.pessoa.nome_completo
      ]
    end

    before do
      create(:atendimento)
      process :search_result, method: :get, params: {
        locale: 'pt-BR',
        patients_my_medical_records_search_form: search_params
      }
    end

    context 'when search params are valid' do
      it { expect(response).to render_template(:search_result) }
      it { expect(response.status).to eq(200) }
      it { expect(assigns(:atendimentos)).to eq([atendimento]) }
    end

    context 'when search params are not valid' do
      let(:search_params) do
        Hash[
          initial_date: nil,
          final_date: nil,
          doctor_name: nil
        ]
      end

      it { expect(response).to render_template(:index) }
      it { expect(response.status).to eq(200) }
      it { expect(assigns(:atendimentos)).to be_blank }
    end
  end

  describe 'GET show' do
    let(:atendimento_id) { 0 }

    context 'when atendimento is prenset' do
      before do
        process :show, method: :get, params: {
          locale: 'pt-BR',
          id: atendimento_id
        }
      end

      let!(:atendimento) { create(:atendimento, pessoa: current_pessoa) }
      let(:atendimento_id) { atendimento.id }
      it { expect(response).to render_template(:show) }
      it { expect(response.status).to eq(200) }
      it { expect(assigns(:atendimento)).to eq(atendimento) }
    end

    context 'when atendimento is not prenset' do
      it do
        expect do
          process :show, method: :get, params: {
            locale: 'pt-BR',
            id: atendimento_id
          }
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
