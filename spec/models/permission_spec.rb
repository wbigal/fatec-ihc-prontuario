require 'rails_helper'

RSpec.describe Permission, type: :model do
  it { is_expected.to validate_presence_of(:date) }
end
