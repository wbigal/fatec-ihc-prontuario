require 'rails_helper'

RSpec.describe Doctors::MyAppointmentsController, :authenticated_doctor,
               type: :controller do
  it { is_expected.to be_kind_of(Doctors::BaseController) }

  describe 'GET index' do
    before do
      process :index, method: :get, params: { locale: 'pt-BR' }
    end

    it { expect(response).to render_template(:index) }
    it { expect(response.status).to eq(200) }
    it do
      expect(assigns(:search)).to be_an_instance_of(
        Doctors::MyAppointments::SearchForm
      )
    end
  end

  describe 'GET search_result' do
    let!(:atendimento) { create(:atendimento, medico: current_pessoa_medico) }
    let(:search_params) do
      Hash[
        initial_date: 1.day.ago,
        final_date: 1.day.from_now,
        patient_name: atendimento.pessoa.nome_completo
      ]
    end

    before do
      create(:atendimento)
      Atendimento.__elasticsearch__.create_index!(index: Atendimento.index_name,
                                                  force: true)
      Atendimento.import(force: true, refresh: true)
      process :search_result, method: :get, params: {
        locale: 'pt-BR',
        doctors_my_appointments_search_form: search_params
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
          patient_name: nil
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

      let!(:atendimento) { create(:atendimento, medico: current_pessoa_medico) }
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
