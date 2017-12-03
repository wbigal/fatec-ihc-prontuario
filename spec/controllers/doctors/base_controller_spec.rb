require 'rails_helper'

RSpec.describe Doctors::BaseController, type: :controller do
  it { is_expected.to be_kind_of(AuthenticatedController) }
end
