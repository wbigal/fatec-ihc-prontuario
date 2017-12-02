require 'rails_helper'

RSpec.describe Person, type: :model do
  it { is_expected.to validate_presence_of(:cns) }
  it { is_expected.to validate_presence_of(:birth_date) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }

  it { is_expected.to have_many(:permissions)}
  it { is_expected.to have_many(:attendances)}
end
