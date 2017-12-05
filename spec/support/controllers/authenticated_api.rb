RSpec.configure do |config|
  config.before(:each, :authenticated_api) do
    request.headers['Authorization'] = token_header
  end

  def token_header
    ActionController::HttpAuthentication::Token.encode_credentials(
      ENV['API_ACCESS_TOKEN']
    )
  end
end
