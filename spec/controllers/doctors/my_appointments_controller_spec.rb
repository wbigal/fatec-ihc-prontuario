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

  describe 'GET index' do
    let(:atendimento) { create(:atendimento, medico: current_pessoa_medico) }
    let(:search_params) do
      Hash[
        initial_date: 1.day.ago,
        final_date: 1.day.from_now,
        patient_name: atendimento.pessoa.nome_completo
      ]
    end

    before do
      create(:atendimento)
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
end
