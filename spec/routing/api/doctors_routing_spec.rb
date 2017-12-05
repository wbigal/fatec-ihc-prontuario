require 'rails_helper'

RSpec.describe Api::DoctorsController, type: :routing do
  describe '#create' do
    it do
      expect(post: '/api/doctors').to route_to('api/doctors#create')
    end
  end
end
