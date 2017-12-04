require 'rails_helper'

RSpec.describe Accounts::Sessions::LoginForm, type: :form do
  it { is_expected.to be_kind_of(FormBase) }

  describe '#email' do
    it { is_expected.to validate_presence_of(:email) }
  end

  describe 'password' do
    it { is_expected.to validate_presence_of(:password) }
  end
end
