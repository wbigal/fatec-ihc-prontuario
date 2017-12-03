require 'rails_helper'

RSpec.describe WelcomeController, :authenticated, type: :controller do
  it { is_expected.to be_kind_of(ApplicationController) }

  describe 'GET index' do
    before do
      get :index
    end

    it { expect(response).to render_template(:index) }
    it { expect(response.status).to eq(200) }
  end
end
