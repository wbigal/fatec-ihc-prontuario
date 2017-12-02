require 'rails_helper'

RSpec.describe Doctor, type: :model do
  it { is_expected.to validate_presence_of(:crm) }

  it { is_expected.to have_many(:permissions)}
  it { is_expected.to have_many(:attendances)}
end
