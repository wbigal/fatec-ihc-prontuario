require 'rails_helper'

RSpec.describe Api::DoctorsController, :authenticated_api, type: :controller do
  it { is_expected.to be_kind_of(Api::BaseController) }

  describe 'POST create' do
    let(:pessoa) { create(:pessoa) }
    let(:cns) { pessoa.cns }
    let(:crm) { Faker::Number.number(6) }

    let(:medico_params) { Hash[cns: cns, crm: crm] }

    context 'when medico data is corrent' do
      it do
        expect do
          process :create, method: :post, params: { medico: medico_params }
        end.to change(Medico, :count).from(0).to(1)
      end

      it do
        process :create, method: :post, params: { medico: medico_params }
        expect(response.status).to eq(201)
      end
    end

    context 'when pessoa is medico' do
      let!(:medico) { create(:medico) }
      let(:pessoa) { medico.pessoa }

      it do
        expect do
          process :create, method: :post, params: { medico: medico_params }
        end.not_to change(Medico, :count)
      end

      it do
        process :create, method: :post, params: { medico: medico_params }
        expect(response.status).to eq(422)
      end
    end

    context 'when medico data is incorrect' do
      let(:medico_params) { Hash[cns: cns, crm: nil] }

      it do
        process :create, method: :post, params: { medico: medico_params }
        expect(response.status).to eq(422)
      end
    end

    context 'when cns is invalid' do
      let(:medico_params) { Hash[cns: 'A', crm: crm] }

      it do
        expect do
          process :create, method: :post, params: { medico: medico_params }
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
