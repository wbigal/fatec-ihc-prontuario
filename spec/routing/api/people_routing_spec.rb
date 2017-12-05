require 'rails_helper'

RSpec.describe Api::PeopleController, type: :routing do
  describe '#create' do
    it do
      expect(post: '/api/people').to route_to('api/people#create')
    end
  end
end
