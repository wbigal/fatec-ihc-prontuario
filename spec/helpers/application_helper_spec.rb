require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#pessoa_signed_in?' do
    it { expect(helper).to delegate_method(:pessoa_signed_in?).to(:controller) }
  end

  describe '#current_pessoa' do
    it { expect(helper).to delegate_method(:current_pessoa).to(:controller) }
  end
end
