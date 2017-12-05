require 'rails_helper'

RSpec.describe Api::BaseController, type: :controller do
  it do
    is_expected.to be_kind_of(
      ActionController::HttpAuthentication::Token::ControllerMethods
    )
  end
end
