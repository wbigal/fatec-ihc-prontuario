require 'rails_helper'

RSpec.describe WelcomeController, type: :routing do
  describe '#index' do
    it { expect(get: '/').to route_to('welcome#index') }
  end
end
