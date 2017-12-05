require 'rails_helper'

RSpec.describe Api::PeopleController, :authenticated_api, type: :controller do
  it { is_expected.to be_kind_of(Api::BaseController) }

  describe 'POST create' do
    let(:pessoa_params) do
      Hash[
        cns: Faker::Number.number(16).to_s,
        nome_completo: 'Fabio Carille',
        data_nascimento: Date.new(1973, 9, 26)
      ]
    end

    context 'when pessoa data is corrent' do
      it do
        expect do
          process :create, method: :post, params: { pessoa: pessoa_params }
        end.to change(Pessoa, :count).from(0).to(1)
      end

      it do
        process :create, method: :post, params: { pessoa: pessoa_params }
        expect(response.status).to eq(201)
      end
    end

    context 'when pessoa data is not corrent' do
      let(:pessoa_params) do
        Hash[
          cns: nil,
          nome_completo: nil,
          data_nascimento: nil
        ]
      end

      it do
        expect do
          process :create, method: :post, params: { pessoa: pessoa_params }
        end.not_to change(Pessoa, :count)
      end

      it do
        process :create, method: :post, params: { pessoa: pessoa_params }
        expect(response.status).to eq(422)
      end
    end
  end
end
