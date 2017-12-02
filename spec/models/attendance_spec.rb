require 'rails_helper'

RSpec.describe Attendance, type: :model do
  it { is_expected.to validate_presence_of(:date) }
  it { is_expected.to validate_presence_of(:symptoms) }
  it { is_expected.to validate_presence_of(:diagnostic) }

  it { is_expected.to have_one(:permission)}
end
