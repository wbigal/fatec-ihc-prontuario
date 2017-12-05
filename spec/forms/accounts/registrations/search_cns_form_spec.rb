require 'rails_helper'

RSpec.describe Accounts::Registrations::SearchCnsForm, type: :form do
  it { is_expected.to be_kind_of(FormBase) }

  describe '#cns' do
    it { is_expected.to validate_presence_of(:cns) }
    it { is_expected.to validate_length_of(:cns).is_equal_to(16) }
  end
end
